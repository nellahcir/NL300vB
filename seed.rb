#!/opt/local/bin/ruby
#
# seed database for KlondiWT300 Race app
#
# 2010Jul19 : nellA hciR
#
# MySQL stores times in UTC so need to adjust time
# ---------------------------------------
require 'rubygems'
require 'mysql'
require 'date'
# ---------------------------------------

def calcStartTime(st)
  tim = Time.local(st[0,4].to_i, st[5,2].to_i, st[8,2].to_i, st[11,2].to_i, st[14,2].to_i, st[17,2].to_i)
  #tim = tim.gmtime
end
# ---------------------------------------

#$dbh = Mysql.real_connect('nellahcir.com', 'nellahci_hcir', 'enaj70', 'nellahci_wt300')
$dbh = Mysql.real_connect('localhost', 'hcir', 'enaj70', 'nl300')

result = $dbh.query("select startInterval from timedcps")
row = result.fetch_row
startInterval = row[0].to_i
result = $dbh.query("select id from checkpoints where sequence = 1")
row = result.fetch_row
checkpoint_id = row[0]
result = $dbh.query("select starttime from timedcps")
row = result.fetch_row
g_start_time = row[0]
year = g_start_time[0,4].to_i

$dbh.query("truncate checkins")
$dbh.query("truncate checkouts")

to = calcStartTime(g_start_time)

result = $dbh.query("select id, dogs, stpos from mushers where year = #{year} order by stpos")
result.each_hash(with_table=true) do |row|
  datestr = to.strftime("%Y-%m-%d %H:%M:%S")
  $dbh.query("insert into checkins value(0, now(), now(), #{row["mushers.id"]}, #{checkpoint_id},
    #{row["mushers.dogs"].to_s}, '#{datestr}')")
    $dbh.query("insert into checkouts value(0, now(), now(), #{row["mushers.id"]}, #{checkpoint_id},
      #{row["mushers.dogs"].to_s}, '#{datestr}')")
  to += (startInterval * 60)
end

# insert the time stagger for each musher
=begin
query=<<-EOT
select m.id from mushers as m 
left join statuses as s on s.id = m.status_id
where s.proceed = TRUE
order by stpos DESC
EOT
result = $dbh.query(query)
diff = 0
result.each_hash(with_table=true) do |row|
  $dbh.query("update mushers set restartdiff = #{diff} where id = #{row[mushers.id]}")
  diff += startInterval
end
=end

$dbh.close if $dbh