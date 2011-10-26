class Checkout < ActiveRecord::Base
  
  belongs_to :checkpoint
  belongs_to :musher

  validates_presence_of   :dogs, :on => :create
  validates_uniqueness_of :checkpoint_id, :scope => [:musher_id]
  
end
