class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.boolean :p1_win, :default => false
      t.boolean :p2_win, :default => false
      t.integer :round_id
      t.belongs_to :round
      t.timestamps
    end
    t.add_index :games, :round_id
  end
end
