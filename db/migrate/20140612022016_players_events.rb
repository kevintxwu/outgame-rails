class PlayersEvents < ActiveRecord::Migration
  def change
    create_table :players_events, :id => false do |t| # ID => FALSE = IMPORTANT
      t.references :player
      t.references :event
      # NO TIMESTAMPS
    end
  end
end
