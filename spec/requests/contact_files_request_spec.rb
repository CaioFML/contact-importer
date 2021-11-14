describe ContactFilesController do
  before { sign_in user }

  let(:user) { create(:user) }

  describe "GET #index" do
    subject! { get contact_files_path }

    before { contact_files }

    let(:contact_files) { create_list(:contact_file, 3) }
    let(:user) { create(:user, contact_files: contact_files) }

    it { expect(response).to have_http_status :ok }

    it "displays contact files" do
      expect(assigns(:contact_files)).to match_array(contact_files)
    end
  end

  describe "GET #new" do
    subject!(:get_new) { get new_contact_file_path }

    it { expect(response).to have_http_status :ok }
  end

  describe "POST #create" do
    subject(:post_create) { post contact_files_path, params: params }

    let(:params) do
      {
        contact_file: { file: fixture_file_upload("valid_contacts.csv"), user_id: user.id },
        columns: {
          name: "0",
          date_of_birth: "1",
          phone: "2",
          address: "3",
          credit_card: "4",
          email: "5"
        }
      }
    end

    it "attaches uploaded file" do
      expect { post_create }.to change(ActiveStorage::Attachment, :count).by(1)
    end

    it "creates contact file" do
      expect { post_create }.to change(ContactFile, :count).by 1
    end

    it "enqueues import contacts job" do
      post_create

      expect(ImportContactsJob).to have_been_enqueued.with(ContactFile.first, params[:columns])
    end

    it "displays flash notice" do
      post_create

      expect(flash[:notice]).to eq "File was successfully import, wait for the contact importing processing!"
    end

    it do
      post_create

      expect(response).to redirect_to contact_files_path
    end
  end
end
