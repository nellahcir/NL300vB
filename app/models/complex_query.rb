class Complex_Query < ActiveRecord::Base
  
  #require 'ostruct'
  
  def self.RestTime(id)
    # Notice how you can, and should, still sanitize params here. 
    result = self.connection.execute(sanitize_sql("select
    time_to_sec(timediff(co.time,ci.time)) AS time 
    from ((((checkins ci 
    left join checkouts co on(((co.musher_id = ci.musher_id) and (co.checkpoint_id = ci.checkpoint_id)))) 
    left join mushers m on((m.id = ci.musher_id))) 
    left join checkpoints c on((c.id = ci.checkpoint_id))) 
    left join checkins ci2 on(((ci.musher_id = ci2.musher_id) and (ci.checkpoint_id < ci2.checkpoint_id)))) 
    where isnull(ci2.musher_id) and ci.musher_id = '#{id}'"))
    while row = result.fetch_row do
       restT = row[0]
    end
    restT.to_f
  end
  
end # <--- end class