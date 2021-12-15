class ImportContactsJob
  include Sidekiq::Worker

  def perform(contact_file_id, column_params)
    contact_file = ContactFile.find(contact_file_id)

    contact_file.processing!

    ImportContacts.call(contact_file: contact_file, column_params: column_params)
  end
end
