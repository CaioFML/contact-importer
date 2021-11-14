RSpec.describe "layouts/_alerts.html.erb" do
  before do
    allow(view).to receive(:flash).and_return flash

    render
  end

  context "when flash is not present" do
    let(:flash) { nil }

    it "renders nothing" do
      expect(rendered).to be_blank
    end
  end

  context "when view has flash notice" do
    let(:flash) { { notice: "Something good happened" } }

    it "renders notice" do
      expect(rendered).to have_selector "div[class='alert alert-info alert-dismissible fade show']",
                                        text: "Something good happened"
    end
  end

  context "when view has flash alert" do
    let(:flash) { { alert: "Something bad happened" } }

    it "renders alert" do
      expect(rendered).to have_selector "div[class='alert alert-danger alert-dismissible fade show']",
                                        text: "Something bad happened"
    end
  end
end
