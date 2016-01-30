class WebhooksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate!
  def create
    if params[:ref] == "refs/heads/master"
      repo_name = params[:repository][:full_name]
      Project.sync(repo_name)
    end
    render nothing: true
  end
end
