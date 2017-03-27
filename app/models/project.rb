class Project < ActiveRecord::Base
  validates :title, 
    :presence => true, 
    :uniqueness => {:case_sensitive => false}
  has_many :items
  scope :active, -> { where(:active => true) }

  def active_items
    items.active
  end

  def deactivate_items
    active_items.complete.update_all(:active => false)
  end
end
