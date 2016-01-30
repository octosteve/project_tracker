class CommitRatioAnalyser
  attr_reader :project
  def self.call(project)
    self.new(project).call
  end

  def initialize(project)
    @project = project
  end

  def call
    project.commits.each_with_object(Hash.new(0)) do |commit, container|
      container[author_format(commit)] += 1
    end
  end

  def author_format(commit)
    commit.author.name
  end
end
