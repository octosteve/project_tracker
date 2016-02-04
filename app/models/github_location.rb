class GithubLocation
  attr_reader :github_url, :commit_hash, :full_path, :line_number
  def initialize(full_path, line_number, github_url, commit_hash)
    @full_path = full_path
    @line_number = line_number
    @github_url = github_url
    @commit_hash = commit_hash
  end

  def to_s
    "#{github_url}/blob/#{commit_hash}#{file_path}#L#{line_number}"
  end

  # Support db/schema.rb
  def file_path
    full_path.scan(/projects\/.*?(\/.*?)$/).join
  end
end
