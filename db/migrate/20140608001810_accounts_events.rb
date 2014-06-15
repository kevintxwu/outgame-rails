class AccountsEvents < ActiveRecord::Migration
  def change
    create_table :accounts_events, :id => false do |t| # ID => FALSE = IMPORTANT
      t.references :account
      t.references :event
      # NO TIMESTAMPS
    end
  end
end
