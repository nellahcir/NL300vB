class Musher < ActiveRecord::Base
  
  belongs_to :standing
  belongs_to :status
  
  validates_uniqueness_of :stpos
  validates_uniqueness_of :name
  validates_uniqueness_of :bibnum
  validates_presence_of   :dogs
  
  def bibnum_with_name
    "#{bibnum} #{name}"
  end

  def self.NumMushers()
    numM = find_by_sql("select count(*) as num from mushers as m left join statuses as s on s.id = m.status_id where s.proceed = true")
    numM[0].num.to_i
  end
  
end
