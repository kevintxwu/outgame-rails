class RemovePlayersEvents < ActiveRecord::Migration
  def change
    drop_table :players_events
  end
end
