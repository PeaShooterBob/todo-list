describe "add a new project", :type => :feature do
  it "recieves an error when not filling out the form correctly" do
    visit(new_project_path)
    
    click_button("Submit")

    expect(page).to have_content("Title can't be blank")
  end
end
