describe ContactFilesController do
  before { sign_in user }

  describe "GET #index" do
    subject! { get contact_files_path }

    before { contact_files }

    let(:contact_files) { create_list(:contact_file, 3) }
    let(:user) { create(:user, contact_files: contact_files) }

    it { expect(response).to have_http_status :ok }

    it "displays content files" do
      expect(assigns(:contact_files)).to match_array(contact_files)
    end
  end
end
