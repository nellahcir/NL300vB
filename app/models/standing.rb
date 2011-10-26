class Standing < ActiveRecord::Base
  
  require 'parsedate'
  
  belongs_to :checkpoint
  belongs_to :musher

  validates_presence_of   :dogsin, :on => :create
  validates_presence_of   :dogsout, :on => :update
  validates_uniqueness_of :checkpoint_id, :scope => [:musher_id]
  
  def self.numRaceMiles()
    miles = find_by_sql("select sum(milepost) as miles from checkpoints")
    miles = miles[0].miles.to_f
  end
  
  # cheat here on the last checkpoint id and the 0k status id
  def self.TimeToFinish(mid)
    t = "still in race..."
    status = find_by_sql("select status_id from mushers where id = #{mid}")
    if status[0].status_id.to_i == 6
      endTime = find_by_sql("select time from checkins where checkpoint_id = 5 and musher_id = #{mid}")
      startTime   = find_by_sql("select time from checkouts where checkpoint_id = 1 and musher_id = #{mid}")
      restartdiff = find_by_sql("select restartdiff as mins from mushers where id = #{mid}")
      dt_start  = Time.mktime(*ParseDate.parsedate(startTime[0].time.to_s))
      dt_end    = Time.mktime(*ParseDate.parsedate(endTime[0].time.to_s))     
      subT      = dt_end - dt_start + (restartdiff[0].mins.to_i * 60)
      subT      = subT.to_i
      hours     = subT / 3600
      mins      = (subT - (hours * 3600)) / 60
      t         = sprintf("%02d:%02d", hours, mins)
    end
  end
  
  def self.LastUpdated()
    lci = find_by_sql("select updated_at as lci from checkins where id = (select max(id) from checkins)")
    lco = find_by_sql("select updated_at as lco from checkouts where id = (select max(id) from checkouts)")
    if lci[0].lci > lco[0].lco
      lci[0].lci
    else
      lco[0].lco
    end
  end
  
  def self.Musher_Standings(musher_id)
    query=<<-EOQ
    select m.name as Musher, m.bibnum as Bibnum, c.name as Checkpoint, 
    ci.dogs as DogsIN, 
    ci.time as TimeIN, 
    co.dogs as DogsOUT, 
    co.time as TimeOUT,
    (timediff(ci.time,(select time from checkouts coinner where coinner.musher_id = ci.musher_id and coinner.checkpoint_id=ci.checkpoint_id-1))) as RunTime,
    (timediff(co.time, ci.time)) as RestTime,
    (select milepost from checkpoints where id = ci.checkpoint_id) / 
    (time_to_sec(
    (timediff(ci.time,(select time from checkouts coinner where coinner.musher_id = ci.musher_id and coinner.checkpoint_id=ci.checkpoint_id-1))) ) / 3600) as speed
    from checkins ci
    left join checkouts co on co.musher_id = ci.musher_id AND co.checkpoint_id = ci.checkpoint_id
    left join mushers as m on m.id = ci.musher_id
    left join checkpoints as c on c.id = ci.checkpoint_id
    where ci.musher_id = #{musher_id}
    order by c.sequence DESC
    EOQ
    find_by_sql(query)
  end
  
  def self.Checkpoint_standings(checkpoint_id)
    query=<<-EOQ
    select m.name as Musher, m.bibnum as Bibnum, c.name as Checkpoint, 
    ci.dogs as DogsIN, 
    ci.time as TimeIN, 
    co.dogs as DogsOUT, 
    co.time as TimeOUT,
    (timediff(ci.time,(select time from checkouts coinner where coinner.musher_id = ci.musher_id and coinner.checkpoint_id=ci.checkpoint_id-1))) as RunTime,
    (timediff(co.time, ci.time)) as RestTime,
    (select milepost from checkpoints where id = ci.checkpoint_id) / 
    (time_to_sec((timediff(ci.time,(select time from checkouts coinner where coinner.musher_id = ci.musher_id and coinner.checkpoint_id=ci.checkpoint_id-1))))/3600) as speed
    from checkins ci
    left join checkouts co on co.musher_id = ci.musher_id AND co.checkpoint_id = ci.checkpoint_id
    left join mushers as m on m.id = ci.musher_id
    left join checkpoints as c on c.id = ci.checkpoint_id
    where c.id = #{checkpoint_id}
    order by isnull(co.time),co.time, ci.time 
    EOQ
    find_by_sql(query)
  end  
  
  def self.All_standings_spd
    query=<<-EOT
    select 
    m.name AS Musher,
    m.bibnum AS Bibnum,
    c.name AS Checkpoint,
    ci.dogs AS DogsIN,
    ci.time AS TimeIN,
    co.dogs AS DogsOUT,
    co.time AS TimeOUT,
    timediff(ci.time,(
      select coinner.time AS time 
      from checkouts coinner 
      where ((coinner.musher_id = ci.musher_id) and (coinner.checkpoint_id = (ci.checkpoint_id - 1))))) AS RunTime,
    timediff(co.time,ci.time) AS RestTime,
    (select milepost from checkpoints where id = ci.checkpoint_id) / 
    (time_to_sec(
    timediff(ci.time,(
      select coinner.time AS time 
      from checkouts coinner 
      where ((coinner.musher_id = ci.musher_id) and (coinner.checkpoint_id = (ci.checkpoint_id - 1))))) ) / 3600) as speed
    from ((((checkins ci left join checkouts co on(((co.musher_id = ci.musher_id) and (co.checkpoint_id = ci.checkpoint_id)))) 
    left join mushers m on((m.id = ci.musher_id))) 
    left join checkpoints c on((c.id = ci.checkpoint_id))) 
    left join checkins ci2 on(((ci.musher_id = ci2.musher_id) and (ci.checkpoint_id < ci2.checkpoint_id)))) 
    where isnull(ci2.musher_id) 
    group by ci.musher_id,co.musher_id 
    order by c.sequence desc,isnull(co.time),co.time,ci.time
    EOT
    find_by_sql(query)
  end
  
  def self.AllMushers
    query=<<-EOT
    select m.name as Musher, m.bibnum as Bibnum, c.name as Checkpoint, 
    ci.dogs as DogsIN, 
    ci.time as TimeIN, 
    co.dogs as DogsOUT, 
    co.time as TimeOUT,
    (timediff(ci.time,(select time from checkouts coinner where coinner.musher_id = ci.musher_id and coinner.checkpoint_id=ci.checkpoint_id-1))) as RunTime,
    (timediff(co.time, ci.time)) as RestTime,
    (select milepost from checkpoints where id = ci.checkpoint_id) / 
    (time_to_sec(
    (timediff(ci.time,(select time from checkouts coinner where coinner.musher_id = ci.musher_id and coinner.checkpoint_id=ci.checkpoint_id-1))) ) / 3600) as speed
    from checkins ci
    left join checkouts co on co.musher_id = ci.musher_id AND co.checkpoint_id = ci.checkpoint_id
    left join mushers as m on m.id = ci.musher_id
    left join checkpoints as c on c.id = ci.checkpoint_id
    order by m.name, c.sequence DESC
    EOT
    find_by_sql(query)
  end
  
  def self.MushersFromStandings()
    query=<<-EOT
    select 
    m.name AS name
    from ((((checkins ci left join checkouts co on(((co.musher_id = ci.musher_id) and (co.checkpoint_id = ci.checkpoint_id)))) 
    left join mushers m on((m.id = ci.musher_id))) 
    left join checkpoints c on((c.id = ci.checkpoint_id))) 
    left join checkins ci2 on(((ci.musher_id = ci2.musher_id) and (ci.checkpoint_id < ci2.checkpoint_id)))) 
    where isnull(ci2.musher_id) 
    group by ci.musher_id,co.musher_id 
    order by c.sequence desc,isnull(co.time),co.time,ci.time
    EOT
    find_by_sql(query)
  end
  
  def self.MushersDidNotStart()
    query=<<-EOT
    select m.name as name 
    from mushers as m
    left join statuses as s on s.id = m.status_id
    where s.name = 'Did_not_start'
    EOT
    find_by_sql(query)
  end

end # <--- end Class


=begin
  def self.All_standings
    query =<<-EOT 
      select 
      m.name AS Musher,
      m.bibnum AS Bibnum,
      c.name AS Checkpoint,
      ci.dogs AS DogsIN,
      ci.time AS TimeIN,
      co.dogs AS DogsOUT,
      co.time AS TimeOUT,
      timediff(ci.time,(
        select coinner.time AS time 
        from checkouts coinner 
        where ((coinner.musher_id = ci.musher_id) and (coinner.checkpoint_id = (ci.checkpoint_id - 1))))) AS RunTime,
      timediff(co.time,ci.time) AS RestTime 
      from ((((checkins ci left join checkouts co on(((co.musher_id = ci.musher_id) and (co.checkpoint_id = ci.checkpoint_id)))) 
      left join mushers m on((m.id = ci.musher_id))) 
      left join checkpoints c on((c.id = ci.checkpoint_id))) 
      left join checkins ci2 on(((ci.musher_id = ci2.musher_id) and (ci.checkpoint_id < ci2.checkpoint_id)))) 
      where isnull(ci2.musher_id) 
      group by ci.musher_id,co.musher_id 
      order by c.sequence desc,isnull(co.time),co.time,ci.time
    EOT
    find_by_sql(query)
  end
=end