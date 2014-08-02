class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :rounds
  accepts_nested_attributes_for :rounds, :update_only => true
  serialize :teams, Array 
  serialize :scores, Hash 

  #THE FOLLOWING IS FOR 1v1 NON-ELIM ONLY
  # This is super hacky because it was originally
  # set up for 2 team matches.
  #
  # The round number is used for bye information,
  # while the teams hash is a pair table to
  # ensure that matchups don't happen more than
  # once.
  #
  # Also, the score hash depends on the hash order
  # to retrieve players, as well as holding scores.
  #
  # Once setup_match() has been called, adding
  # additional players to the event will have
  # no effect on the matchup/scores.
  #
  # TODO: Find better methods for generating
  # pairs and storing data.

  def setup_match
    # there must be at least two players.
    # TODO: this needs an assert statement.

    players = users.select { |u| u.type = 'Player' }
    players.shuffle!

    self.scores = Hash.new
    # use score hash to hold players
    players.each do |p|
      self.scores[p] = [0,0,0] #Losses, Wins, Ties
    end
  end

  def generate_round
    if rounds.length == 0
      setup_match
    end

    # advance round num
    r_num = rounds.empty? ? 1 : rounds.last.round_number + 1

    curr_round = Round.new(round_number: r_num, active: true)

    # order players from lowest to highest score 
    self.scores.sort_by { |p, s| s[1] }
    players = Array.new
    self.scores.each do |p,s|
      players << p
    end

    # use round num for bye (convert to index).
    # needed only if bye is present
    # also, mod is used so this will reset
    # after everyone has been out once.
    if players.count % 2 != 0
      index = r_num % players.count
      pool << index
      curr_round.byes = { index => true }
    end

    #set previous round as history
    if rounds.last
      rounds.last.active = false
      rounds.last.save!
    end

    # create matchups
    # TODO: account for byes
    matchups = Array.new
    keys = self.scores.keys
    i = 0
    for i in 0..(players.count/2-1) do
      matchups << [keys[2*i], keys[2*i+1]] 
    end

    # make games 
    matchups.each do |p1,p2|
      new_game = make_and_return_game(p1,p2)
      curr_round.games << new_game
      curr_round.save!
    end
    rounds << curr_round
    save!
  end

  def make_and_return_game(player_1,player_2)
      game = Game.new #winner is set later
      game.contestants << player_1
      game.contestants << player_2 
      game.save!
      return game
  end

  # score format is [L,W,T]
  def calculate_scores
    self.scores.each do |k,v|
      self.scores[k] = [0,0,0]
    end
    rounds.each do |r|
      r.games.each do |g|
	p1 = g.contestants[0]
	p2 = g.contestants[1]
	puts p1
	if g.tie?
	  self.scores[p1][2] += 1
	  self.scores[p2][2] += 1
	  # may as well update the tie while we're here
	  g.p1_win = false
	  g.p2_win = false
	  g.save!
	elsif g.p1_win?
	  self.scores[p1][1] += 1
	  self.scores[p2][0] += 1
	else
	  self.scores[p1][0] += 1
	  self.scores[p2][1] += 1
	end
      end 
      save!
   end
  end

end
