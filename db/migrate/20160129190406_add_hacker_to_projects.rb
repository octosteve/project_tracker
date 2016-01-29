class AddHackerToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :hacker, index: true, foreign_key: true
  end
end
