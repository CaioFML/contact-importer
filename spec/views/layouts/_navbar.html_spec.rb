describe "layouts/_navbar.html.erb" do
  before { render }

  it "displays application name" do
    expect(rendered)
      .to have_selector "a.d-flex.align-items-center.mb-3.mb-md-0.me-md-auto.text-dark.text-decoration-none",
                        text: "Contacts Importer"
  end

  it "displays link to home" do
    expect(rendered).to have_link "Home", href: contacts_path
  end

  it "displays link to contacts" do
    expect(rendered).to have_link "Contacts", href: contacts_path
  end

  it "displays link to contact files" do
    expect(rendered).to have_link "Contacts files", href: contact_files_path
  end

  it "displays link to logout" do
    expect(rendered).to have_link "Logout", href: destroy_user_session_path
  end
end
