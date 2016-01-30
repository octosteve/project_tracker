class ProjectAnalyser
  attr_reader :project
  def initialize(project)
    @project = project
  end

  def commit_ratios
    CommitRatioAnalyser.call(project)
  end
end
