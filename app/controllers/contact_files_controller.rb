class ContactFilesController < ApplicationController
  def index
    @contact_files = current_user.contact_files
  end

  def new; end

  def create; end
end
