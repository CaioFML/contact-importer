describe "ContactFiles" do
  describe "#new" do
    before do
      sign_in user

      visit new_contact_file_path
    end

    let(:user) { create(:user) }

    it "imports file" do
      attach_file "contact_file_file", "spec/fixtures/files/valid_contacts.csv"
      select "One", from: "contact_file[columns][name]"
      select "Two", from: "contact_file[columns][date_of_birth]"
      select "Three", from: "contact_file[columns][phone]"
      select "Four", from: "contact_file[columns][address]"
      select "Five", from: "contact_file[columns][credit_card]"
      select "Six", from: "contact_file[columns][email]"

      click_on "Import"

      expect(page).to have_content "File was successfully import, wait for the contact importing processing!"
    end
  end
end
