describe "soft deletes a project", :type => :feature do
  include ProjectNotice

  context "when a user deletes a project"
  it "will not see that project, but it will exist in the database" do
    project = Project.create!(:title => "Climb K2") 
    visit(projects_path)

    click_button("Destroy")   

    expect(page).to_not have_content("Climb K2")
    expect(Project.find(project.id)).to_not be nil
  end

  it "will not allow to see an individual inactive project" do
    project = Project.create!(:title => "Dance like MJ", :active => false) 
    visit(project_path(project))

    expect(page).to have_content(ProjectNotice::INACTIVE_PROJECT)
  end
end
