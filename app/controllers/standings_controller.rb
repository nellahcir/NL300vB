class StandingsController < ApplicationController
  
  before_filter :except => :login do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1, "view" => 1, "public" => 1 })
  end
	layout :writers_and_readers
		
	def index
    @checkpoints = Checkpoint.find(:all)
    if params[:search] and params[:search] != "" then
      musher = Musher.find(:all, :conditions => "bibnum = #{params[:search]}")
      @standings = Standing.Musher_Standings(musher[0].id)
      @status = generateStatus(musher)
    else
      @lastupdated = Standing.LastUpdated
      @standings = Standing.All_standings_spd
      @status = generateStatus('all')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @standings }
    end
  end
  
  def singlemusher()
    @musher = Musher.find(:all, :conditions => "name = '#{params[:musher]}'")
    @standings = Standing.Musher_Standings(@musher[0].id)
    @status = generateStatus(@musher)
    t = Standing.TimeToFinish(@musher[0].id)
    @subTtime = t
  end
  
  def allmushers()
    @status = {}
    #@mushers = Musher.find(:all, :order => "name")
    # !! list mushers in the order they finished the race !!
    activeMushers = Standing.MushersFromStandings()
    dnsMushers    = Standing.MushersDidNotStart()
    @mushers      = activeMushers + dnsMushers
    
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    numRaceMiles = Standing.numRaceMiles()
    @firstcp = @checkpoints.shift
    @lastcp = @checkpoints.pop
    logger.debug @lastcp.name
    standings = Standing.AllMushers
    @runtimes = {}
    mushers = Musher.find(:all, :order => "name")
    mushers.each do |musher|
      begin
        if musher.status.name != '0k'
          @runtimes["#{musher.name}"] = musher.status.name
          @runtimes["#{musher.name}Spd"] = ""
        else
          t = Standing.TimeToFinish(musher.id)
          if t.nil?
            @runtimes["#{musher.name}"] = ""
          else
            @runtimes["#{musher.name}"] = t
            hours = t[0,2].to_i + t[3,2].to_i / 60.0
            ##rtime = raceTime_toTime(@runtimes["#{musher.name}"])
            @runtimes["#{musher.name}Spd"] = numRaceMiles / hours ##@runtimes["#{musher.name}"].to_f
          end
        end
      rescue
        1
      end
    end
    @h = {}
    standings.each do |standing|
      @h["#{standing.Musher}#{standing.Checkpoint}TimeIN"]  = standing.TimeIN
      @h["#{standing.Musher}#{standing.Checkpoint}TimeOUT"] = standing.TimeOUT
      @h["#{standing.Musher}#{standing.Checkpoint}DogsIN"]  = standing.DogsIN
      @h["#{standing.Musher}#{standing.Checkpoint}DogsOUT"] = standing.DogsOUT
    end
  end
  
  def singlecheckpoint()
    @checkpoints = Checkpoint.find(:all)
    @status = {}
    @standings = Standing.Checkpoint_standings(params[:findcheckpoint][:checkpoint_id])
  end

# =  - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = 

  private
  
  def raceTime_toTime(t)
    parts = t.split(':')
    hours = parts[0].to_i + parts[1].to_i / 60.0
  end

  def generateStatus(musher)
    status = []
    s2 = Hash.new()
    if musher == 'all'
      standings = Standing.all
    else
      standings = Standing.find(:all, :conditions => "Bibnum = #{musher[0].bibnum}")
    end
    numM = Musher.NumMushers()
    ####numM = numM[0].num.to_i
    # numM = 23 2011feb05 limit to w status.proceed is true
    finishCP = Checkpoint.find(:last)
    standings.each do |standing|
      m = standing.Musher
      ##debugger
      musher = Musher.find(:all, :conditions => "name = '#{m}'")
      timedCPID = Timedcp.all
      thisCheckpoint = Checkpoint.find(:all, :conditions => "name = '#{standing.Checkpoint}'")
      if timedCPID.length != 0
        timedCP = Checkpoint.find(:all, :conditions => "id = '#{timedCPID[0].checkpoint_id}'")
        if not musher[0].status.proceed
          earlyOUT = musher[0].status.name
        elsif (standing.Checkpoint == timedCP[0].name)
          inTime = Checkin.Calcrestartdiff(musher[0].id, timedCP[0].id)
          # NOTE
          # we have a mandatory 6 hour layover + 2 minute interval between mushers
          #
          timedcps = Timedcp.all
          
          # a breach in the rules on waiting more than 2 minutes for a withdrawn musher is the cause
          # of the following if to add layover time to those who started ahead of the missing musher
          #if musher[0].stpos < 19
            # this will not be required in next version as we can simply adjust musher.restartdiff
          #  outTime = inTime[0].time + (timedcps[0].minMakeup * 60) + ((numM - musher[0].stpos) * timedcps[0].startInterval.to_i * 60) + 120
          #else
            # !! use the musher.restartdiff column which is now datafilled via seed.rb !!
            #outTime = inTime[0].time + (timedcps[0].minMakeup * 60) + ((numM - musher[0].stpos) * timedcps[0].startInterval.to_i * 60)
            outTime = inTime[0].time + (timedcps[0].minMakeup * 60) + musher[0].restartdiff.to_i * 60
          #end
          
          ##logger.debug "#{m} - #{inTime[0].time} - #{musher[0].stpos} - #{outTime}"
          outTimeS = outTime.to_s
          earlyOUT = outTimeS.slice(5,11)
        elsif standing.Checkpoint == finishCP.name
          t = Standing.TimeToFinish(musher[0].id)
          earlyOUT = "#{t} finsish"
        elsif thisCheckpoint[0].minrest.to_i > 0
          inTime = Checkin.Calcrestartdiff(musher[0].id, thisCheckpoint[0].id)
          outTime = inTime[0].time + (thisCheckpoint[0].minrest * 60)
          outTimeS = outTime.to_s
          earlyOUT = outTimeS.slice(5,11)
        else
          earlyOUT = "#{musher[0].status.name}"
        end
      else
        earlyOUT = "ERR: no timedcp"
      end
      status.push(earlyOUT)
      s2["#{m}"] = earlyOUT
    end
    ##html += "</table>"
    #status
    s2
  end

end # <--- end Class