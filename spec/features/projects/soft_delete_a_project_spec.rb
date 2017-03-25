describe "soft deletes a project", :type => :feature do
  context "when a user deletes a project"
  it "will not see that project, but it will exist in the database" do
    project = Project.create!(:title => "Climb K2") 
    visit(projects_path)

    click_link("Destroy")   

    expect(page).to_not have_content("Climb K2")
    expect(Project.find(project.id)).to_not be nil
  end
end
