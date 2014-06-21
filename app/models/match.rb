class Match
  include ActiveModel::Model
  attr_accessor :rounds, :team_1, :team_2, :bye, :event, :player_scores

  #teams are designated with numerals 0,1

  def initialize(attributes={})
    super
    @rounds = []
    @offset = -1 #used for matching up teams, incremented every round inc. the first
    #also determines which team member to switch out for bye.
    @bye = []
    #first index is team, second is player name
    @player_scores = Hash.new
    @players = @event.users #check syntax
    #TODO: move scores out of hash.
    @players.each do |p|
      @player_scores[p.name] = 0 #check syntax, need player name for lookup
    end
    setup_match()
  end

  def setup_match()
    #shuffle arrays
    #offset by 1 (offset starts at 0)
    #(offset % length-1) + 1
    #increment offset each round (offset

    #must be at least two players
    assert(players.length >= 2, 
      ['Event must have at least two players'])

    players.shuffle!

    if players.length % 2 > 0 #there is a bye, assign to random team
      index = rand(1)
      @bye[0] = index
      @bye[1] = players.pop
    end

    team_size = players.length/2 #must be even

    @team_1 = players.pop(@team_size)
    @team_2 = players #remaining players

  end

  def advance_round(, )
    #create new games for every player pairing
    offset_index = (@offset % team_1.length) + 1

    #arrange for bye to be switched with offset indexed player
    team_switch = [@team_1, @team_2]
    bye_team = team_switch[@bye[0]]
    temp = @bye[1]
    @bye[1] = bye_team[offset]
    bye_team[offset_index] = temp

    games = []
    new_round = Round.new
    @team_1.length do |t|
      game = Game.new(player_1: @team_1[t], player_2: @team_2[offset_index], 
	       round_number: round_num) 
      offset_index += 1
      games << game
    end

    #add round to match
    @rounds << new_round

  end

  #match is over if every team_list is empty but one
  def is_over?() 
    return 
  end
end
