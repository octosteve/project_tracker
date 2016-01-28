class AddHerokuUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :heroku_url, :string
  end
end
