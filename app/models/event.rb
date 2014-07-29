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

    generate_pairs(players.count)

  end


  def generate_pairs(num_players)
    # create pair table of player indices
    # (generates every possible match
    # combination)
    self.teams = Array.new
    for i in (0 .. num_players-1) do
      for j in (i+1 .. num_players-1) do
	self.teams << [i,j]
      end
    end
  end

  def generate_round
    if rounds.length == 0
      setup_match
    end

    # advance round num
    r_num = rounds.empty? ? 1 : rounds.last.round_number + 1

    curr_round = Round.new(round_number: r_num, active: true)

    # create ordered player array from scores hash
    players = Array.new
    self.scores.each do |p,s|
      players << p
    end

    # create player pool to check matchups against
    pool = Array.new

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
 
    #use pair table (teams) to generate matchups
    if self.teams.empty?
    # restart for now.
    # we should probably end the match at this point.
      generate_pairs(players.count)     
    end

    # the problem of finding the right pairs to
    # guarantee that the maximum number of players
    # will be in a round is similar to finding
    # the longest sequence in a DAG, where 
    # edges go from left to right between 
    # nodes that have space in the pool and
    # nodes that fill that space.
   
    node_prevs = []
    node_pools = []
    for i in 1..teams.count
      node_pools << []
    end
    max = 0 

    teams.each.with_index do |pair,index|
      max = 0 
      prev_index = -1
      for i in (0 .. index)  
      # pool size is score for node
	if node_pools[i].size >= max and fits_in_pool(node_pools[i],pair)
	  max = node_pools[i].size
	  prev_index = i 
	end 
      end 
      # use prev index == -1 as marker to start of sequence
      node_prevs[index] = prev_index
      if prev_index == -1
	node_pools[index] = [] + pair
      else
	node_pools[index] = node_pools[prev_index] + pair
      end 
    end 

    max = 0 
    last_index = 0 
    matchups = []
    node_pools.each.with_index do |p, index|
      if p.size > max 
	max = p.size
	last_index = index
      end 
    end 

    prev_index = last_index
    done = false
    while true do
      matchups << teams[prev_index]
      prev_index = node_prevs[prev_index]
      if done == true
	  break
      end
      if prev_index == node_prevs[prev_index]
	  done = true
      end
    end

    # make games and delete matchups from pair table.
    matchups.each do |p1,p2|
      self.teams.delete([p1,p2])
      new_game = make_and_return_game(players[p1],players[p2])
      curr_round.games << new_game
      curr_round.save!
    end
    rounds << curr_round
    save!

=begin
    teams_copy = Marshal.load(Marshal.dump(self.teams))
    count = players.count
    while count > 1 do
      teams_copy.each do |match| # note that p1,p2 are indices
	p1 = match[0]
	p2 = match[1]
	if !pool.include? p1 and !pool.include? p2
	  new_game = make_and_return_game(players[p1],players[p2])
	  curr_round.games << new_game
	  curr_round.save!
	  pool << p1
	  pool << p2
	  self.teams.delete(match) # take pair out of table
	  count -= 2
	end
      end
    end
    rounds << curr_round
    save!
=end
  end

  def fits_in_pool(pool,pair)
    return (!pool.include? pair[0] and !pool.include? pair[1])
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
   end
  end

end
