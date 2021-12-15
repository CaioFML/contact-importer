class ContactFilesController < ApplicationController
  def index
    @contact_files = current_user.contact_files
  end

  def new
    @contact_file = ContactFile.new
  end

  def create
    @contact_file = ContactFile.new(contact_file_params)

    @contact_file.save

    ImportContactsJob.perform_async(@contact_file.id, columns_params.to_h)

    redirect_to contact_files_path, notice: "File was successfully import, wait for the contact importing processing!"
  end

  private

  def contact_file_params
    params.require(:contact_file).permit(:file, :user_id)
  end

  def columns_params
    params.require(:contact_file).permit(columns: %i[name date_of_birth phone address credit_card email])
  end
end
