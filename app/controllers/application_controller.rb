class ApplicationController < ActionController::Base
  respond_to :html, :json

  before_action :authenticate_user!

  protect_from_forgery unless: -> { request.format.json? }
end
