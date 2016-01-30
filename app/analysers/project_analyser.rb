class ProjectAnalyser
  attr_reader :project
  def initialize(project)
    @project = project
  end

  def commit_ratios
    CommitRatioAnalyser.call(project)
  end

  def overall_commit_frequency
    CommitFrequencyAnalyser.call(project)
  end

  def overall_commit_frequency
    OverallCommitFrequencyAnalyser.call(project)
  end

  def individual_commit_frequency
    IndividualCommitFrequencyAnalyser.call(project)
  end

  def criticisms
    CriticismsAnalyser.call(project)
  end
end
