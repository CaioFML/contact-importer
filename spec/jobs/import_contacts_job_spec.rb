describe ImportContactsJob do
  describe "#perform" do
    subject(:perform) { described_class.perform_now(contact_file, column_params) }

    let(:contact_file) { create(:contact_file) }
    let(:column_params) do
      {
        name: "0",
        date_of_birth: "1",
        phone: "2",
        address: "3",
        credit_card: "4",
        email: "5"
      }
    end

    it "cancels coupons" do
      expect(ImportContacts).to receive(:call).with(contact_file: contact_file, column_params: column_params)

      perform
    end
  end
end
