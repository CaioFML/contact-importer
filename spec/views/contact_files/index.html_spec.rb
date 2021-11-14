describe "contact_files/index.html.erb" do
  before do
    assign(:contact_files, contact_files)

    render
  end

  let(:contact_files) do
    [
      create(:contact_file, file: fixture_file_upload("valid_contacts.csv"), log: "waiting for processing"),
      create(:contact_file,
             status: :processing,
             file: fixture_file_upload("valid_contacts.csv"),
             log: "everything is good")
    ]
  end

  it "displays header" do
    expect(rendered).to have_content "Contact Files"
  end

  it "displays table headers" do
    expect(rendered).to have_content "File name"
    expect(rendered).to have_content "Status"
    expect(rendered).to have_content "Log"
  end

  it "displays first content file" do
    expect(rendered).to have_selector("table tbody tr[1] td[1]", text: "valid_contacts.csv")
    expect(rendered).to have_selector("table tbody tr[1] td[2]", text: "on_hold")
    expect(rendered).to have_selector("table tbody tr[1] td[3]", text: "waiting for processing")
  end

  it "displays second content file" do
    expect(rendered).to have_selector("table tbody tr[2] td[1]", text: "valid_contacts.csv")
    expect(rendered).to have_selector("table tbody tr[2] td[2]", text: "processing")
    expect(rendered).to have_selector("table tbody tr[2] td[3]", text: "everything is good")
  end
end
