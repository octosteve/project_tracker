class AddGithubUsernameToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :github_username, :string
  end
end
