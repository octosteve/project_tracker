class CommitRatioAnalyser
  attr_reader :project
  def self.call(project)
    self.new(project).call
  end

  def initialize(project)
    @project = project
  end

  def call
    commits = project.commits
    commits.each_with_object(Hash.new(0)) do |commit, container|
      container[author_format(commit)] += 1
    end
  end

  def author_format(commit)
    author = commit.author
    "#{author.name}  - #{author.email}"
  end
end
