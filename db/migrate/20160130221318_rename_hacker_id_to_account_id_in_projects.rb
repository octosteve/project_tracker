class RenameHackerIdToAccountIdInProjects < ActiveRecord::Migration
  def change
    remove_index :projects, :hacker_id
    remove_foreign_key :projects, :hackers
    rename_column :projects, :hacker_id, :account_id
    add_index :projects, :account_id
    add_foreign_key :projects, :accounts
  end
end
