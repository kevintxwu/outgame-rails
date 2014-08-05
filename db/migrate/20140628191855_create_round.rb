class CreateRound < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :event
      t.integer :event_id
      t.boolean :active
      t.integer :round_number
      t.text :byes
      t.timestamps
    end
    add_index :rounds, :event_id
  end
end
