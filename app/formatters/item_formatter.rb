class ItemFormatter
  NEWLINE = "\n"
  CHECKMARK = "X"
  def self.format(item_action, done)
    checkbox = pick_checkbox(done)
    "#{checkbox} #{item_action}#{NEWLINE}"
  end

  private

  def self.pick_checkbox(done)
    done ? "[#{CHECKMARK}]" : "[ ]"
  end
end
