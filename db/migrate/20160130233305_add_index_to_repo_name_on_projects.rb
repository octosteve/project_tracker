class AddIndexToRepoNameOnProjects < ActiveRecord::Migration
  def change
    add_index :projects, :repo_name
  end
end
