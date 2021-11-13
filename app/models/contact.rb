class Contact < ApplicationRecord
  belongs_to :user

  before_validation :detect_franchise, :set_credit_card_last_four_digits

  validates :name, :date_of_birth, :phone, :address, :credit_card, :email, :franchise, :credit_card_last_four_digits,
            presence: true
  validates :name,
            format: { with: /\A[a-zA-Z\s-]+\z/, message: "Special characters is not allowed, you can use only \"-\"" }
  validates :email, uniqueness: { scope: :user_id }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ }
  validates :phone, format: { with: /\A(\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2})|
                                     (\(\+\d{2}\)\s\d{3}-\d{3}-\d{2}-\d{2})\z/x,
                              message: "Only the formats (+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed" }

  validate :date_of_birth_format

  private

  def date_of_birth_format
    Date.iso8601(date_of_birth)
  rescue Date::Error
    errors.add(:date_of_birth, "only the formats YYYYMMDD and YYYY-MM-DD are allowed")
  end

  def detect_franchise
    brand_name = CreditCardValidations::Detector.new(credit_card).brand_name
    self.franchise = brand_name
  end

  def set_credit_card_last_four_digits
    return if credit_card.blank?

    self.credit_card_last_four_digits = credit_card&.last(4)
    self.credit_card = BCrypt::Password.create(credit_card)
  end
end
