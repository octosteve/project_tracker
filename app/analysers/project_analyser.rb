class ProjectAnalyser
  attr_reader :project
  def self.call(project)
    self.new(project).call
  end

  def initialize(project)
    @project = project
  end

  def call
    CommitRatioAnalyser.call(project)
    CommitFrequencyAnalyser.call(project)
    OverallCommitFrequencyAnalyser.call(project)
    RailsBestPracticesAnalyser.call(project)
    CriticismsAnalyser.call(project)
    IndividualCommitFrequencyAnalyser.call(project)
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

  def best_practices
    RailsBestPracticesAnalyser.call(project)
  end
end
