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
    paths = ['app', 'lib'].map {|dir| project.local_repo_path + '/' + dir }
    analysis = Rubycritic::CommandFactory
                            .create(paths: paths)
                            .critique
                            .reject{|a| a.smells.empty?}
                            .sort_by{|a| -a.smells.count}
                            .each do |a|
                              a.smells.each do |smell|
                                smell.locations.map! do |location|
                                  project.github_url + "/blob/" + project.commits.last.to_s + location.pathname.to_s.scan(/\/app\/.*?$/).join + "#L" + location.line.to_s
                                end
                              end
                            end

  end
end
