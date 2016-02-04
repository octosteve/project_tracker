class CriticismsAnalyser
  DIRS = ['app', 'lib']
  class CriticismCollection
    def self.new(criticisms, project)
      criticisms.map do |criticism|
        Criticism.new(criticism, project)
      end
      .sort_by{|c| -c.smells.count}
    end
  end

  class Criticism
    attr_reader :name, :smells
    def initialize(criticism, project)
      @name = criticism["name"]
      @smells = set_smells(criticism["smells"], project)
    end

    private
    def set_smells(smells, project)
      smells.map {|s| Smell.new(s, project)}
    end
  end

  class Smell
    attr_reader :type, :details, :locations
    def initialize(smell, project)
      @type = smell["type"]
      @details = set_details(smell)
      @locations = set_locations(smell, project)
    end

    private
    def set_details(smell)
      "#{smell["context"]}: #{smell["message"]}"
    end

    def set_locations(smell, project)
      smell["locations"].map do |location|
        GithubLocation.new(location["pathname"]["path"], location["line"], project.github_url, project.latest_commit_hash).to_s
      end
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
    c = RubycriticCriticism.find_by(commit_hash: project.latest_commit_hash)
    return CriticismCollection.new(c.payload, project) if c

    paths = generate_project_paths
    criticisms = Rubycritic::CommandFactory
                            .create(paths: paths)
                            .critique
                            .reject{|a| a.smells.empty?}
    c = project.rubycritic_criticisms.create(commit_hash: project.latest_commit_hash, payload: criticisms)
    CriticismCollection.new(c.payload, project)
  end

  private

  def generate_project_paths
    DIRS.map {|dir| "#{project.local_repo_path}/#{dir}" }
  end
end
