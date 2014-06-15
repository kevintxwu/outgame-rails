class RemoveAccounts < ActiveRecord::Migration
  def up 
    drop_table :accounts 
    drop_table :accounts_events
  end

  def down
  end
end
