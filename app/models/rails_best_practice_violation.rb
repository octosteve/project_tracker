class RailsBestPracticeViolation < ActiveRecord::Base
  belongs_to :project
  def self.create_from_error(error, project)
    project
      .rails_best_practice_violations
      .create(commit_hash: project.latest_commit_hash,
              violation: error.type.demodulize.gsub(/Review$/, "").underscore.humanize,
              more_info_url: error.url,
              message: error.message,
              file_name: error.filename,
              line_number: error.line_number
             )
  end

  def github_url
    AnalyzerHelpers::GithubLocation.new(file_name, line_number, project.github_url, commit_hash).to_s
  end
end
