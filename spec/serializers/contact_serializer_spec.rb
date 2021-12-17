describe ContactSerializer do
  describe ".serializable_hash" do
    subject(:serialize) { described_class.new(contact).serializable_hash }

    let(:contact) do
      create(:contact,
             name: "Bruce Wayne",
             date_of_birth: Date.new(1915, 4, 17),
             email: "bruce@wayne.com",
             address: "some street, 123, some neighbourhood in some city")
    end

    let(:serialized_hash) do
      {
        id: contact.id,
        name: "Bruce Wayne",
        date_of_birth: "1915 April 17",
        phone: "(+57) 320-432-05-09",
        address: "some street, 123, some neighbourhood in some city",
        credit_card_last_four_digits: "1111",
        franchise: "Visa",
        email: "bruce@wayne.com"
      }
    end

    it { expect(serialize).to eq serialized_hash }
  end
end
