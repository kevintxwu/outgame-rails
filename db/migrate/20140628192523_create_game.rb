class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :winner, :default => nil
      t.integer :round_id
      t.belongs_to :round
      t.timestamps
    end
    t.add_index :games, :round_id
  end
end
