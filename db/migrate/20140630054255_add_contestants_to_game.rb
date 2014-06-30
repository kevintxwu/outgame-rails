class AddContestantsToGame < ActiveRecord::Migration
  def change
    add_column :games, :contestants, :text
  end
end
