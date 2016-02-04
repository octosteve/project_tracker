class RailsBestPracticesAnalyser
  attr_reader :project
  def self.call(project)
    self.new(project).call
  end

  def initialize(project)
    @project = project
  end

  def call
    violations = RailsBestPracticeViolation.where(commit_hash: project.latest_commit_hash)
    return violations if violations.any?

    analyzer = RailsBestPractices::Analyzer.new(project.local_repo_path)
    analyzer.analyze
    analyzer
    .errors
    .select {|error| %r{#{project.local_repo_path}} =~ error.filename}
    .map do |error|
      RailsBestPracticeViolation
        .create_from_error(error, project)
    end
  end
end
