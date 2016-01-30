class Project < ActiveRecord::Base
  REPO_PATTERN = /\Ahttps?:\/\/github.com\/(?<username>.*?)\/(?<repo>.*?)\/?\z/
  validates :name, :github_url, :heroku_url, presence: true
  validates :github_url, format: {with: REPO_PATTERN, message: "must start with http(s)://github.com"}
  validates :repo_name, uniqueness: {message: "is already being tracked"}

  belongs_to :hacker

  def setup!
    set_repo_name
    return false if invalid?
    return false if invalid_github_repo?
    clone!
    save!
  end

  def commits
    local_repo.log.to_a.reverse
  end

  def invalid_github_repo?
    !valid_github_repo?
  end

  def valid_github_repo?
    if !!hacker.find_repo(repo_name)
      true
    else
      errors[:github_url] << "Must be a valid Repository"
      false
    end
  end


  def clone!
    Git.clone(clone_source, project_directory)
  end

  def canonical_project_name
    repo_name.split("/").last
  end

  def canonical_project_owner
    repo_name.split("/").first
  end

  def clone_source
    "http://github.com/" + repo_name + ".git"
  end

  private
  def set_repo_name
    self.repo_name = github_url.scan(REPO_PATTERN).join("/")
  end

  def project_directory
    File.join(Rails.root,
              "projects",
              canonical_project_name)
  end

  def local_repo
    Git.open(project_directory)
  end

end
