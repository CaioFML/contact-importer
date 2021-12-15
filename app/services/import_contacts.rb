class ImportContacts < ApplicationService
  require "csv"

  attr_reader :contact_file, :column_params, :initialized_contacts

  def initialize(contact_file:, column_params:)
    @contact_file = contact_file
    @column_params = column_params.symbolize_keys
    @initialized_contacts = []
  end

  def call
    parse_csv_file.each_with_index do |content, index|
      contact = initialize_contact(content)

      initialized_contacts << contact

      next if contact.save

      contact_file.update!(log: build_error_log_message(contact, index))
    end

    return contact_file.failed! unless some_contact_persisted?

    contact_file.finished!
  end

  private

  def parse_csv_file
    CSV.parse(contact_file.file.download).tap(&:shift)
  end

  def initialize_contact(content)
    Contact.new(name: file_content(content, :name),
                date_of_birth: file_content(content, :date_of_birth),
                phone: file_content(content, :phone),
                address: file_content(content, :address),
                credit_card: file_content(content, :credit_card),
                email: file_content(content, :email),
                user: contact_file.user)
  end

  def build_error_log_message(contact, index)
    error_log_message = "Error on row #{index + 2}: #{contact.errors.full_messages.join(', ')};"

    return contact_file.log.concat(" #{error_log_message}") if contact_file.log.present?

    error_log_message
  end

  def file_content(content, column_params_name)
    content[column_params[:columns][column_params_name].to_i]
  end

  def some_contact_persisted?
    initialized_contacts.any?(&:persisted?)
  end
end
