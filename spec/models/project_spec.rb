require 'rails_helper'

RSpec.describe Project, :type => :model do
  subject { Project.new(params) }

  let(:params) {
    {
      :title => 'Some Big Project'
    }
  }

  describe "validations" do
    it "is valid with valid params" do
      expect(subject).to be_valid
    end

    it "requires a title" do
      params[:title] = ''

      expect(subject).to_not be_valid
      expect(subject.errors.keys).to eq [:title]
    end

    it "requires title be unique within a project" do
      subject.save

      duplicate_action = Project.new(params)

      expect(duplicate_action).to_not be_valid
      expect(duplicate_action.errors.keys).to include :title
    end

    it "requires title to be unique ignoring case" do
      subject.save

      params[:title] = params[:title].downcase
      duplicate_action = Project.new(params)

      expect(duplicate_action).to_not be_valid
      expect(duplicate_action.errors.keys).to include :title
    end
  end

  describe "#active_items" do
    it "only returns active items" do
      subject.save

      item = subject.items.create!(:action => "do the dishes")

      expect(subject.active_items.first).to eq(item)
    end

    it "does not return inactive items" do
      subject.save

      item = subject.items.create!(:action => "Play Leagues",
                                   :active => false)

      expect(subject.active_items).not_to include(item)
    end
  end
end

