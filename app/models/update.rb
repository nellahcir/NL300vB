class Update < ActiveRecord::Base
  
  belongs_to :checkpoint
  belongs_to :musher
  
  def self.find_last_update(id)
    rid = find_by_sql("select max(id) as id from updates where musher_id = #{id}")
  end
  
end
