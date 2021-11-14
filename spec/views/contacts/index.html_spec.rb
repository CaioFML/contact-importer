describe "contacts/index.html.erb" do
  before do
    assign(:contacts, paginate_view(contacts))

    render
  end

  let(:contacts) do
    [
      create(:contact,
             name: "Alvaro",
             date_of_birth: "19901020",
             phone: "(+57) 320-432-05-09",
             address: "some street number 5",
             credit_card: "5555555555554444",
             franchise: "MasterCard",
             email: "test@test.com"),
      create(:contact,
             name: "Daniel",
             date_of_birth: "19940510",
             phone: "(+57) 320-432-05-03",
             address: "some street number 6",
             credit_card: "4111111111111111",
             franchise: "Visa",
             email: "test2@test.com")
    ]
  end

  it "displays header" do
    expect(rendered).to have_content "Contacts"
  end

  it "displays table headers" do
    expect(rendered).to have_content "Name"
    expect(rendered).to have_content "Email"
    expect(rendered).to have_content "Date of birth"
    expect(rendered).to have_content "Phone"
    expect(rendered).to have_content "Address"
    expect(rendered).to have_content "Credit card"
    expect(rendered).to have_content "Franchise"
  end

  it "displays first contact" do
    expect(rendered).to have_selector("table tbody tr[1] td[1]", text: "Alvaro")
    expect(rendered).to have_selector("table tbody tr[1] td[2]", text: "test@test.com")
    expect(rendered).to have_selector("table tbody tr[1] td[3]", text: "1990 October 20")
    expect(rendered).to have_selector("table tbody tr[1] td[4]", text: "(+57) 320-432-05-09")
    expect(rendered).to have_selector("table tbody tr[1] td[5]", text: "some street number 5")
    expect(rendered).to have_selector("table tbody tr[1] td[6]", text: "4444")
    expect(rendered).to have_selector("table tbody tr[1] td[7]", text: "MasterCard")
  end

  it "displays second contact" do
    expect(rendered).to have_selector("table tbody tr[2] td[1]", text: "Daniel")
    expect(rendered).to have_selector("table tbody tr[2] td[2]", text: "test2@test.com")
    expect(rendered).to have_selector("table tbody tr[2] td[3]", text: "1994 May 10")
    expect(rendered).to have_selector("table tbody tr[2] td[4]", text: "(+57) 320-432-05-03")
    expect(rendered).to have_selector("table tbody tr[2] td[5]", text: "some street number 6")
    expect(rendered).to have_selector("table tbody tr[2] td[6]", text: "1111")
    expect(rendered).to have_selector("table tbody tr[2] td[7]", text: "Visa")
  end
end
