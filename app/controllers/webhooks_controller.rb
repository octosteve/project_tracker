class WebhooksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate!
  def create
    # binding.pry
    render nothing: true
  end
end
