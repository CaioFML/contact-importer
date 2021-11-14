describe ContactFile do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one_attached(:file) }
  end

  describe "enums" do
    it { expect(build(:contact_file, status: :on_hold)).to be_on_hold }
    it { expect(build(:contact_file, status: :processing)).to be_processing }
    it { expect(build(:contact_file, status: :failed)).to be_failed }
    it { expect(build(:contact_file, status: :finished)).to be_finished }

    context "when initializing a new contact file" do
      it "defines default status" do
        expect(described_class.new).to be_on_hold
      end
    end
  end
end
