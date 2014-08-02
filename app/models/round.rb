class Round < ActiveRecord::Base
  belongs_to :event
  has_many :games, dependent: :destroy
  accepts_nested_attributes_for :games, :update_only => true
  serialize :byes, Hash

  def get_style()
    left = round_number == 0 ? ' left_most' : ''
    history = active? ? '' : ' history'
    return 'third' + left + history
  end

  def get_player_from_name(name)
    return Player.find_by name: name
  end
end
