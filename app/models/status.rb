class Status < ActiveRecord::Base
  
  belongs_to :musher
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
