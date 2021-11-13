describe Contact do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    subject(:contact) { described_class.new }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :date_of_birth }
    it { is_expected.to validate_presence_of :phone }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :credit_card }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :franchise }
    it { is_expected.to validate_uniqueness_of(:email).scoped_to(:user_id) }
    it { is_expected.to allow_value("email@addresse.foo").for(:email) }
    it { is_expected.not_to allow_value("emailaddresse.foo").for(:email) }

    it do
      expect(contact).to allow_value("(+00) 000 000 00 00")
        .for(:phone)
        .with_message("Only the formats (+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed")
    end

    it do
      expect(contact).to allow_value("(+00) 000-000-00-00")
        .for(:phone)
        .with_message("Only the formats (+00) 000 000 00 00 and (+00) 000-000-00-00 are allowed")
    end

    it do
      expect(contact).to allow_value("19960110")
        .for(:date_of_birth)
        .with_message("only the formats YYYYMMDD and YYYY-MM-DD are allowed")
    end

    it do
      expect(contact).to allow_value("1996-01-10")
        .for(:date_of_birth)
        .with_message("only the formats YYYYMMDD and YYYY-MM-DD are allowed")
    end

    it do
      expect(contact).to allow_value("Caio Motta")
        .for(:name)
        .with_message("Special characters is not allowed, you can use only \"-\"")
    end

    it do
      expect(contact).to allow_value("Caio-Motta")
        .for(:name)
        .with_message("Special characters is not allowed, you can use only \"-\"")
    end
  end

  describe "#before_validation" do
    let(:contact) { build(:contact) }

    before { contact.save! }

    it "detects and save brand name by credit card number" do
      expect(contact.franchise).to eq "Visa"
    end

    context "when credit card number is present" do
      it "encrypts credit card number" do
        expect(BCrypt::Password.new(contact.credit_card)).to eq "4111111111111111"
      end

      it "saves only last four numbers of credit card" do
        expect(contact.credit_card_last_four_digits).to eq "1111"
      end
    end
  end
end
