describe ImportContacts do
  describe "#call" do
    subject(:call) { described_class.call(contact_file: contact_file, column_params: column_params) }

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

    shared_examples "imports all contacts" do
      it "creates contacts" do
        expect { call }.to change(Contact, :count).by 3
      end

      it "changes status of contact file" do
        call

        expect(contact_file).to be_finished
      end

      it "does not updates the contact file log" do
        call

        expect(contact_file.log).to be_blank
      end
    end

    context "with all valid data on file" do
      let(:contact_file) { create(:contact_file, status: :processing, file: fixture_file_upload("valid_contacts.csv")) }

      include_examples "imports all contacts"
    end

    context "with different order of columns on file" do
      let(:contact_file) do
        create(:contact_file, status: :processing, file: fixture_file_upload("different_order_of_columns.csv"))
      end

      let(:column_params) do
        {
          name: "4",
          date_of_birth: "0",
          phone: "5",
          address: "1",
          credit_card: "2",
          email: "3"
        }
      end

      include_examples "imports all contacts"
    end

    context "with some invalid data on file" do
      let(:contact_file) do
        create(:contact_file, status: :processing, file: fixture_file_upload("some_invalid_contacts.csv"))
      end

      it "creates contacts" do
        expect { call }.to change(Contact, :count).by 2
      end

      it "changes status of contact file" do
        call

        expect(contact_file).to be_finished
      end

      it "updates the contact file log with the line that has errors" do
        call

        expect(contact_file.log).to eq "Error on row 2: Name Special characters is not allowed, "\
                                       "you can use only \"-\", Email is invalid, Phone Only the formats "\
                                       "(+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed;"
      end
    end

    context "with all invalid data on file" do
      let(:contact_file) do
        create(:contact_file, status: :processing, file: fixture_file_upload("all_invalid_contacts.csv"))
      end

      let(:log_messages) do
        <<~TEXT.squish
          Error on row 2: Name Special characters is not allowed, you can use only "-"; \
          Error on row 3: Address can't be blank, Franchise can't be blank, Email is invalid, Phone Only the formats \
          (+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed; Error on row 4: Franchise can't be blank, \
          Name Special characters is not allowed, you can use only "-", Email is invalid, Phone Only the formats \
          (+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed, Date of birth only the formats YYYYMMDD 
          and YYYY-MM-DD are allowed;
        TEXT
      end

      it "creates no contact" do
        expect { call }.to change(Contact, :count).by 0
      end

      it "changes status of contact file" do
        call

        expect(contact_file).to be_failed
      end

      it "updates the contact file log with the line that has error" do
        call

        expect(contact_file.log).to eq log_messages
      end
    end
  end
end
