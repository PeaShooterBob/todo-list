include ProjectNotice

describe "clearing items from a project", :type => :feature do
  it "message for no items to clear " do
    project = Project.create!(:title => "Organize house")
    Item.create!(:action => "Find the broom",
                 :project_id => project.id)

    visit(project_path(project))

    click_button('Clear Completed Items')

    expect(page).to have_content(ProjectNotice::NO_ITEMS_TO_CLEAR)
  end

  context "a non active item that has been complete" do
    it "message for no items to clear" do
      project = Project.create!(:title => "Life a yolo lifestyle")
      Item.create!(:action => "Cancel life insurance",
                   :project_id => project.id,
                   :active => false,
                   :done=> true)
      Item.create!(:action => "Schedule a skydive",
                   :project_id => project.id)
      visit(project_path(project))

      click_button('Clear Completed Items')

      expect(page).to have_content(ProjectNotice::NO_ITEMS_TO_CLEAR)
    end
  end
end
