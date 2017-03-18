describe "add item to a project", :type => :feature do
  it "can see an added item to the project list" do
    project = Project.create!(:title => "Cool guy")
    visit(project_path(project))

    click_link("New Item")
    fill_in("Action", :with => "buy sunglasses")  
    click_button("Create Item")

    expect(page).to have_content("buy sunglasses")
  end
end
