class Project < ActiveRecord::Base
  validates :title, 
    :presence => true, 
    :uniqueness => {:case_sensitive => false}
  has_many :items, :dependent => :destroy
end
