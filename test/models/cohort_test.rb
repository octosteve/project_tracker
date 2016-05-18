require 'test_helper'

class CohortTest < ActiveSupport::TestCase
  test "Deleting a cohort deletes projects and smells" do
    beef = Cohort.create!(name: "Class Beef")
    project = beef.projects.create!(name: "Beef", github_url: "https://github.com/StevenNunez/chicken_Ser", heroku_url: "https://something.herokuapp.com")
    project.rails_best_practice_violations.create!
    project.rubycritic_criticisms.create!

    beef.destroy!
    
    assert Cohort.all.empty?
    assert Project.all.empty?
    assert RailsBestPracticeViolation.all.empty?
    assert RubycriticCriticism.all.empty?
  end
end
