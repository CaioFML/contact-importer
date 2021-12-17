class ContactSerializer < ActiveModel::Serializer
  include ApplicationHelper

  attributes :id, :name, :date_of_birth, :phone, :address, :credit_card_last_four_digits, :franchise, :email

  def date_of_birth
    format_date(object.date_of_birth)
  end
end
