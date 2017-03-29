require "spec_helper"

describe ItemFormatter do
  describe ".format" do
    it "returns a checked box for a finished item" do
      done = true
      item_action = "Hi"
      checked_checkbox = "[#{ItemFormatter::CHECKMARK}]"

      result = ItemFormatter.format(item_action, done)

      expect(result).to eq("#{checked_checkbox} #{item_action}#{ItemFormatter::NEWLINE}")
    end

    it "returns an empty box for a non finished item" do
      done = false
      item_action = "newspaper"

      result = ItemFormatter.format(item_action, done)

      expect(result).to eq("[ ] #{item_action}#{ItemFormatter::NEWLINE}")
    end
  end
end
