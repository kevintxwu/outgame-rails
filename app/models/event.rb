class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :rounds
  serialize :teams, Hash
  serialize :scores, Hash

  #THE FOLLOWING IS FOR TWO TEAM NON-ELIM ONLY

  def setup_match
    #there must be at least two players

    players = users.select { |u| u.type = 'player' }
=begin    
    assert(players.length >= 2,
      ['Event must have at least two players'])
=end 
    players.shuffle!
 
    if players.length % 2 > 0 #there is a bye, assign it to random team
      index = rand(1)
      @byes = {players.pop => index}
    else
      @byes = nil
    end

    team_size = players.length/2 #must be even
    players.each_with_index do |p,i|
      teams[p] = i <= team_size ? 1 : 2
    end
  end

  def rotate_hash(hash,num) 
    hash.replace(hash.to_a.rotate(num).to_h)
  end

  def generate_round
    if rounds.length == 0
      setup_match
    end

    t_1 = teams.select { |k,v| v == 1 }
    t_2 = teams.select { |k,v| v == 2 }
    rotate_hash(t_1,1)
    teams = t_1.merge t_2
    @team_1 = t_1.keys
    @team_2 = t_2.keys
    #keep in mind hash order is preserved.
    #This operation is to offset team 1
    #in order to match players for byes.

    #advance round num
    puts rounds.length
    r_num = rounds.empty? ? 1 : rounds.last.round_number + 1

    #set previous round as history
    if rounds.last
      rounds.last.active = false
      rounds.last.save!
      #@byes = rounds.last.byes 
    end
 
    #switch bye with first player in team
=begin
    if @byes
      bye = @byes.first #assuming only one bye for now. format [player,team#]
      team_switch = [@team_1, @team_2]
      bye_team = team_switch[@byes[0]] 
      temp = @byes
      @byes[1] = bye_team[offset]
      bye_team[offset_index] = temp
      teams
      hash.delete_if
    end
=end
 
    curr_round = Round.new(round_number: r_num, active: true)# byes: @byes)
    @team_1.zip(@team_1).each do |p1,p2| #teams should be same size!
      game = Game.new #winner is set later
      game.contestants = [] #initialize the right way
      game.contestants << p1
      game.contestants << p2
      curr_round.games << game
      game.save!
    end

    rounds << curr_round
    save!
  end

end
