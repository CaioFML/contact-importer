class ImportContactsJob < ApplicationJob
  def perform(contact_file, column_params)
    contact_file.processing!

    ImportContacts.call(contact_file: contact_file, column_params: column_params)
  end
end
