require 'test_helper'

class GithubLocationTest < ActiveSupport::TestCase
  test "Returns valid project path" do
    full_path = "/Users/StevenNunez/school/web-1115/apps/project_tracker/projects/project_tracker/app/models/project.rb"
    location = GithubLocation.new(full_path, nil, nil, nil)
    assert location.file_path == "/app/models/project.rb",  location.file_path
  end

  test "finds path project paths for files in config" do
    full_path = "/Users/StevenNunez/school/web-1115/apps/project_tracker/projects/petpal/config/routes.rb"
    location = GithubLocation.new(full_path, nil, nil, nil)
    assert location.file_path == "/config/routes.rb",  location.file_path
    "/Users/StevenNunez/school/web-1115/apps/project_tracker/projects/petpal/db/migrate/20160128221720_create_comments.rb"
    "/Users/StevenNunez/school/web-1115/apps/project_tracker/projects/petpal/db/schema.rb"
  end

  test "finds path project paths for files in db/migrate" do
    full_path = "/Users/StevenNunez/school/web-1115/apps/project_tracker/projects/petpal/db/migrate/20160128221720_create_comments.rb"
    location = GithubLocation.new(full_path, nil, nil, nil)
    assert location.file_path == "/db/migrate/20160128221720_create_comments.rb",  location.file_path

  end
  test "finds path project paths for files in db" do
    full_path = "/Users/StevenNunez/school/web-1115/apps/project_tracker/projects/petpal/db/schema.rb"
    location = GithubLocation.new(full_path, nil, nil, nil)
    assert location.file_path == "/db/schema.rb",  location.file_path
  end
end
