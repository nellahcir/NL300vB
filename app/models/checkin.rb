class Checkin < ActiveRecord::Base
  
  belongs_to :checkpoint
  belongs_to :musher

  validates_presence_of   :dogs, :on => :create
  validates_uniqueness_of :checkpoint_id, :scope => [:musher_id]
  
  def self.Calcrestartdiff(id, cpID)
    find_by_sql("select time from checkins where musher_id='#{id}' and checkpoint_id = '#{cpID}'")
  end
  
  def self.MData(id)
    mxmn = find_by_sql("select max(id) as mx, min(id) as mn from checkins where musher_id = #{id}")
    startT = find_by_sql("select time from checkins where id = #{mxmn[0].mn}")
    endT = find_by_sql("select time from checkins where id = #{mxmn[0].mx}")
    runT = endT[0].time - startT[0].time
  end
  
end
