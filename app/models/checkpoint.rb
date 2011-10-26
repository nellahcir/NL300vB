class Checkpoint < ActiveRecord::Base
  
  belongs_to :standing
  
  validates_uniqueness_of :name
  validates_uniqueness_of :sequence
  
  validates_presence_of   :milepost
  validates_presence_of   :minrest
  
  def self.getNextSeq()
    result = find_by_sql("select max(sequence) as sequ from checkpoints")
    nextSeq = result[0].sequ.to_i + 1
  end
  
end
