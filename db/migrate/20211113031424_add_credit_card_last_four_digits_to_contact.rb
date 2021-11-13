class AddCreditCardLastFourDigitsToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :credit_card_last_four_digits, :string
  end
end
