describe User do
  describe "associations" do
    it { is_expected.to have_many(:contacts).dependent(:destroy) }
    it { is_expected.to have_many(:contact_files).dependent(:destroy) }
  end
end
