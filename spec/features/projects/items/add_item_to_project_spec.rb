describe "add item to a project", :type => :feature do
  it "can see an added item to the project list" do
    project = Project.create!(:title => "Cool guy") 
    visit(project_path(project))

    click_button("New Item")
    fill_in("Action", :with => "buy sunglasses")  
    click_button("Submit")

    expect(page).to have_content("buy sunglasses")
  end
end
