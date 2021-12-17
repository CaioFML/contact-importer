describe API::V1::ContactsController do
  let(:user) { create(:user) }

  describe "GET #index" do
    context "with authentication" do
      subject(:get_index) { get api_v1_contacts_path, headers: authenticated_header(user) }

      def format_date(date)
        Date.iso8601(date).strftime("%Y %B %d")
      end

      def format_contact_date_of_birth_attribute_hash(contacts_json)
        contacts_json.each do |contact|
          contact["date_of_birth"] = format_date(contact["date_of_birth"])
        end
      end

      before do
        contacts

        get_index
      end

      let(:contacts) { create_list(:contact, 5, user: user) }
      let(:expected_contacts) do
        contacts
          .as_json(only: %i[id name date_of_birth phone address credit_card_last_four_digits franchise email])
          .tap { |contacts_json| format_contact_date_of_birth_attribute_hash(contacts_json) }
      end

      it { expect(response).to have_http_status :ok }

      it "returns contacts" do
        expect(body_json).to contain_exactly(*expected_contacts)
      end
    end
  end

  context "without authentication" do
    subject!(:get_index) { get api_v1_contacts_path }

    it { expect(response).to have_http_status :unauthorized }
  end
end
