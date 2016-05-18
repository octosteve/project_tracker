require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "must have a name, github and heroku url" do
    project = Project.new
    refute project.valid?, "Should be invalid"
    assert project.errors[:name].include?("can't be blank"), project.errors[:name]
    assert project.errors[:github_url].include?("can't be blank"), project.errors[:github_url]
    assert project.errors[:heroku_url].include?("can't be blank"), project.errors[:heroku_url]
  end

  test "github url must point to github.com" do
    project = Project.new(github_url: "http://reddit.com/StevenNunez/ProjectTracker")
    project.valid?
    assert project.errors[:github_url].include?("must start with http(s)://github.com"), project.errors[:github_url]
  end

  test "can extract github repo name" do
    project = Project.new(github_url: "https://github.com/StevenNunez/ProjectTracker")
    project.setup!
    assert(project.repo_name == "StevenNunez/ProjectTracker", project.repo_name)

    project = Project.new(github_url: "http://github.com/StevenNunez/ProjectTracker/")
    project.setup!
    assert(project.repo_name == "StevenNunez/ProjectTracker", project.repo_name)
  end

  test "it fetches the repository" do
    project = Project.new(github_url: "https://github.com/StevenNunez/project_tracker")
    project.setup!
    project.clone!
    cloned_directory = File.join(Rails.root, "projects", "project_tracker")
    assert(Dir.exist?(cloned_directory), "Directory should have been cloned")
  end
end
