class AddUsersEvents < ActiveRecord::Migration
  def change
    create_table :users_events, :id => false do |t| # ID => FALSE = IMPORTANT
      t.references :user
      t.references :event
      # NO TIMESTAMPS
    end
  end
end
