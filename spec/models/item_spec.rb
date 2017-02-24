require 'rails_helper'

RSpec.describe Item, :type => :model do
  subject { Item.new(params) }

  let(:params) {
    {
      :action => 'Do something',
      :project_id => 123,
    }
  }

  describe '#project_title' do
    let(:project_title) { 'Some Project Title' }
    let(:project) { Project.new(:title => project_title).freeze }
    let(:params) do
      { :action => 'Do something',
        :project => project }
    end

    it 'is the project title' do
      expect(subject.project_title).to eq(project_title)
    end
  end

  describe "validations" do
    it "is valid with valid params" do
      expect(subject).to be_valid
    end

    it "requires an action" do
      params[:action] = ''

      expect(subject).to_not be_valid
    end

    it "requires action be unique within a project" do
      subject.save

      duplicate_action = Item.new(params)

      expect(duplicate_action).to_not be_valid
      expect(duplicate_action.errors.keys).to include :action
    end
  end
end
