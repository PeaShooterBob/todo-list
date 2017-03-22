describe "clearing items from a project", :type => :feature do
  context "there are items" do
    it "none have been completed" do
      project = Project.create!(:title => "Organize house")
      Item.create!(:action => "Find the broom",
                          :project_id => project.id)

      visit(project_path(project))

      click_link('Clear Completed Items')

      expect(page).to have_content('There are no completed items for this project')
    end
  end
end
