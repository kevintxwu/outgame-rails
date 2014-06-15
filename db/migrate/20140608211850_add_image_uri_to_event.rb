class AddImageUriToEvent < ActiveRecord::Migration
  def change
    add_column :events, :image, :string
  end
end
