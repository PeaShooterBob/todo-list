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
end
