module ErrorFormatter
  def self.format(errors)
    errors.full_messages.reduce('') do |full_message, error|
      full_message = error + "\n"
    end
  end
end
