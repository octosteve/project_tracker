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
      @name = criticism.name
      @smells = set_smells(criticism.smells, project)
    end

    private
    def set_smells(smells, project)
      smells.map {|s| Smell.new(s, project)}
    end
  end

  class Smell
    attr_reader :type, :details, :locations
    def initialize(smell, project)
      @type = smell.type
      @details = set_details(smell)
      @locations = set_locations(smell, project)
    end

    private
    def set_details(smell)
      "#{smell.context}: #{smell.message}"
    end

    def set_locations(smell, project)
      smell.locations.map do |location|
        GithubLocation.new(location, project.github_url, project.latest_commit_hash).to_s
      end
    end
  end

  class GithubLocation
    attr_reader :location, :github_url, :commit_hash
    def initialize(location, github_url, commit_hash)
      @location = location
      @github_url = github_url
      @commit_hash = commit_hash
    end

    def to_s
      "#{github_url}/blob/#{commit_hash}#{file_path}#L#{location.line}"
    end

    def file_path
      location.pathname.to_s.scan(/\/app\/.*?$/).join
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
    paths = generate_project_paths
    criticisms = Rubycritic::CommandFactory
                            .create(paths: paths)
                            .critique
                            .reject{|a| a.smells.empty?}

    CriticismCollection.new(criticisms, project)
  end

  private

  def generate_project_paths
    DIRS.map {|dir| "#{project.local_repo_path}/#{dir}" }
  end
end
