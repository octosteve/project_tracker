class GithubSessionsController < ApplicationController
  skip_before_filter :authenticate!
  def create
    @account = Account.find_or_create_from_github(auth_hash)
    session[:account_id] = @account.id
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth'].to_h
  end
end
