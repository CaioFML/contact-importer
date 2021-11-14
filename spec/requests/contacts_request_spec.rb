describe ContactsController do
  before { sign_in user }

  let(:user) { create(:user) }

  describe "GET #index" do
    subject(:get_index) { get contacts_path, params: { page: page } }

    before do
      contacts

      get_index
    end

    let(:contacts) { create_list(:contact, 5, user: user) }

    context "with page params" do
      let(:page) { 1 }

      it { expect(response).to have_http_status :ok }

      it "displays contacts" do
        expect(assigns(:contacts).size).to eq 5
      end
    end

    context "without page params" do
      let(:page) { nil }

      it { expect(response).to have_http_status :ok }

      it "displays contacts" do
        expect(assigns(:contacts).size).to eq 5
      end
    end
  end
end
