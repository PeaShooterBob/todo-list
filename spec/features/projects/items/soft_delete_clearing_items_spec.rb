include ProjectNotice

describe "clearing items from a project", :type => :feature do
  it "user cannot see item, but it still exists in the database" do
    project = Project.create!(:title => "Open a coffee shop")
    item = Item.create!(:action => "Buy a roaster",
                        :project_id => project.id)

    visit(project_path(project))

    click_button('Done')
    click_button('Clear Completed Items')

    expect(page).to_not have_content("Buy a roaster")
    expect(Item.find(item.id)).to_not be nil
  end
end
