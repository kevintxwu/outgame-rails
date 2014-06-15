class SwitchUsersEvents < ActiveRecord::Migration
  def change
    drop_table :users_events
    create_table :events_users, :id => false do |t| # ID => FALSE = IMPORTANT
      t.references :user
      t.references :event
      # NO TIMESTAMPS
    end
  end
end
