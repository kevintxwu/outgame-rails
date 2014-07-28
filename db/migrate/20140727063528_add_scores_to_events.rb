class AddScoresToEvents < ActiveRecord::Migration
  def change
    add_column :events, :scores, :text
  end
end
