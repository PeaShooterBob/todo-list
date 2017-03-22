module ProjectNotice
  CREATE_SUCCESS = 'Project was successfully created.'
  UPDATE_SUCCESS = 'Project was successfully updated.' 
  DESTROY_SUCCESS = 'Project was successfully destroyed.' 
  ITEMS_CLEARED = 'Completed items were successfully cleared.'
  NO_ITEMS_TO_CLEAR = 'There are no completed items for this project'

  def self.format_error_messages(errors)
    errors.full_messages.reduce('') do |full_message, error|
      full_message = error + "\n"
    end
  end
end
