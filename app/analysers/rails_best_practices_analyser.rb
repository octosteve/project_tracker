class RailsBestPracticesAnalyser
  class Error
    attr_reader :type, :message, :url, :line_number
    def initialize(error)
      @type = error.type
      @message = error.message
      @url = error.url
      @line_number = error.line_number
    end

    # # TODO: Local path needs to be passed in

    def github_url
      AnalyzerHelpers::GithubLocation.new()
    end
  end

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
    .map do |error|
      RailsBestPracticeViolation
        .create_from_error(error, project)
    end
  end
end
