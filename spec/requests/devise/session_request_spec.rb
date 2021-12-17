describe Devise::SessionsController do
  describe "api/v1" do
    describe "POST #create" do
      subject! { post api_v1_sign_in_path, params: { user: { email: user.email, password: user.password } } }

      context "with successful login" do
        let(:user) { create(:user) }

        it { expect(response).to have_http_status(:created) }

        it "returns a token" do
          expect(response.headers["Authorization"]).to be_present
        end
      end

      context "with wrong params" do
        let(:user) { instance_double("User", email: "wrong", password: "wrong") }

        it { expect(response).to have_http_status(:unauthorized) }

        it "doesn't return a token" do
          expect(response.headers["Authorization"]).not_to be_present
        end
      end
    end
  end
end
