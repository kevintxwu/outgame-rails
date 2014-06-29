class AddTeamsAndBracketToEvent < ActiveRecord::Migration
  def change
    add_column :events, :bracket_type, :string
    add_column :events, :teams, :text
  end
end
