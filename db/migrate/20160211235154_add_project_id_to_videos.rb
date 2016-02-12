class AddProjectIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :project_id, :integer
  end
end
