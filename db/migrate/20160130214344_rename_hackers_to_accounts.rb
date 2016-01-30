class RenameHackersToAccounts < ActiveRecord::Migration
  def change
    rename_table :hackers, :accounts
  end
end
