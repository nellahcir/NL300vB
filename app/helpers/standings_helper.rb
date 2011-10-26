module StandingsHelper
  
require 'date'
  
  def show_dateS(date)
    if date.nil?
      r = ""
    else
      sd = DateTime.parse(date)
      #offset = -1 * 9.0/24        # -9 hours for Alaska
      d = sd.new_offset(-0.3749)      
      r = d.strftime("%d-%b-%Y %H:%M")
    end
    r
  end
  
  def stest(n)
    if n.nil?
      r = ""
    else
      begin
        sd = DateTime.parse(n.to_s)
        d = sd.new_offset(-0.3749)      
        r = d.strftime("%d-%m %H:%M")
      rescue
        r = n.class
      end
    end
    r
  end

  def show_speed(s)
    str = s.to_s
    if str == ""
      ""
    else
      sprintf("%.2f", str)
    end
  end
  
  def show_speed3(s)
    str = s.to_s
    if str == ""
      ""
    else
      sprintf("%.5f", str)
    end
  end
  
  def show_date(date)
    date.strftime("%m-%d %H:%M")
  end
  
  def show_time(time)
    time.strftime("%H:%M")
  end
  
  def show_HM(secs)
    hs = secs.divmod(3600)
    h = hs[0]
    ms = hs[1].divmod(60)
    m = ms[0]
    sprintf("%d:%02d", h, m)
  end
  
  def show_HM2(t)
    t
  end
   
end
