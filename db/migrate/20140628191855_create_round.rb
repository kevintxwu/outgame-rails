class CreateRound < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :event
      t.integer :event_id
      t.boolean :active
      t.integer :round_number
      t.timestamps
    end
    t.add_index :event_id
  end
end
