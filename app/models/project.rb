class Project < ActiveRecord::Base
  REPO_PATTERN = /\Ahttps?:\/\/github.com\/(?<username>.*?)\/(?<repo>.*?)\/?\z/
  BASE_URL = "http://project-tracker.hostiledeveloper.com"

  validates :name, :github_url, :heroku_url, presence: true
  validates :github_url, format: {with: REPO_PATTERN, message: "must start with http(s)://github.com"}
  validates :repo_name, uniqueness: {message: "is already being tracked"}

  belongs_to :account
  has_many :rails_best_practice_violations

  def self.sync(repo_name)
    project = Project.where("repo_name ILIKE ?", "%#{repo_name}%" ).first
    project.sync
  end

  def sync
    local_repo.pull
  end

  # TODO: This doesn't belong here.
  def add_webhook!
    account
    .client
    .create_hook(repo_name, "web", {
      url: "#{BASE_URL}/webhooks",
      content_type: "json"
    }, {
      events: ["push"],
      active: true
    })
  end

  def setup!
    set_repo_name
    return false if invalid?
    return false if invalid_github_repo?
    # add_webhook!
    clone!
    save!
  end

  def commits
    @commits ||= local_repo.log.to_a.reverse
  end

  def latest_commit
    @latest_commit ||= commits.last
  end

  def latest_commit_hash
    @latest_commit_hash ||= latest_commit.to_s
  end

  def invalid_github_repo?
    !valid_github_repo?
  end

  def valid_github_repo?
    if !!account.find_repo(repo_name)
      true
    else
      errors[:github_url] << "Must be a valid Repository"
      false
    end
  end

  def clone!
    Git.clone(clone_source, local_repo_path)
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

  def local_repo_path
    File.join(Rails.root,
    "projects",
    canonical_project_name)
  end

  private
  def set_repo_name
    self.repo_name = github_url.scan(REPO_PATTERN).join("/")
  end


  def local_repo
    @local_repo ||= Git.open(local_repo_path)
  end
end
