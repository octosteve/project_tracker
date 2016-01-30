class OverallCommitFrequencyAnalyser
  attr_reader :project
  def self.call(project)
    self.new(project).call
  end

  def initialize(project)
    @project = project
  end

  def call
    project
      .commits
      .group_by_day {|u| u.date}
      .map { |k, v| [k, v.size] }
      .to_h
  end
end
