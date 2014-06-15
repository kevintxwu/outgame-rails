class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :date
      t.string :type
      t.string :bracket
      t.string :description

      t.timestamps
    end
  end
end
