class Project < ActiveRecord::Base
  validates :title, 
    :presence => true, 
    :uniqueness => {:case_sensitive => false}
  has_many :items
  scope :active, -> { where(:active => true) }

  def active_items
    items.where(:active => true)
  end
end
