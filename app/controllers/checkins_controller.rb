class CheckinsController < ApplicationController
  
  #before_filter :authorize, :except => :login
	before_filter :except => :login do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1, "view" => 1 })
  end
	layout :writers_and_readers
	
  # GET /checkins
  # GET /checkins.xml
  def index
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')    
    if params[:search] and params[:search] != "" then
      #@checkins = Checkin.search(params[:search], params[:page])
      musher = Musher.find(:all, :conditions => "bibnum = #{params[:search]}")
      @checkins = Checkin.find(:all, :conditions => "musher_id = #{musher[0].id}")
    else
     @checkins = Checkin.paginate(:page => params[:page], :per_page => 25, :order => 'time DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checkins }
    end
  end

  # GET /checkins/1
  # GET /checkins/1.xml
  def show
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @checkin }
    end
  end

  # GET /checkins/new
  # GET /checkins/new.xml
  def new
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkin = Checkin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @checkin }
    end
  end

  # GET /checkins/1/edit
  def edit
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkin = Checkin.find(params[:id])
  end

  # POST /checkins
  # POST /checkins.xml
  def create
    bad = false
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkin = Checkin.new(params[:checkin])
    if @checkin.musher.status.proceed 
      if @checkin.checkpoint.sequence > 1 then
        lastCP = Checkpoint.find(:all, :conditions => "sequence = #{@checkin.checkpoint.sequence} - 1")
        last = Checkout.find(:all, :conditions => "musher_id = #{@checkin.musher_id} and checkpoint_id = #{lastCP[0].id}")
        begin
          if @checkin.time < last[0].time then
            flash[:notice] = "Arriving before leaving last checkpoint! #{last[0].time}"
            bad = true
          end
          if @checkin.dogs.nil?
            flash[:notice] = "Dog count can NOT be blank"
          elsif @checkin.dogs != last[0].dogs then
            flash[:notice] = "Different number of dogs arriving then left last checkpoint #{last[0].dogs}"
          end
        rescue
          flash[:notice] = "Are you sure you data filled the checkin correctly?!"
        end
      end
      respond_to do |format|  
        if not bad
          @checkin.save
          format.html { redirect_to(:controller => :standings, :action => :index) }
          format.xml { redirect_to(:controller => :standings, :action => :index) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @checkin.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "Musher is NOT clear to proceed in race."
      redirect_to(:controller => :standings, :action => :index)
    end
  end # <--- end create

  # PUT /checkins/1
  # PUT /checkins/1.xml
  def update
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkin = Checkin.find(params[:id])
    
    if @checkin.checkpoint.sequence > 1 then
      #last = Checkout.find(:all, :conditions => "musher_id = #{@checkin.musher_id} and checkpoint_id = #{@checkin.checkpoint_id} - 1")
      lastCP = Checkpoint.find(:all, :conditions => "sequence = #{@checkin.checkpoint.sequence} - 1")
      last = Checkout.find(:all, :conditions => "musher_id = #{@checkin.musher_id} and checkpoint_id = #{lastCP[0].id}")
      if @checkin.time < last[0].time then
        flash[:notice] = "Arriving before leaving last checkpoint! #{last[0].time}"
      end
      if @checkin.dogs != last[0].dogs then
        flash[:notice] = "Different number of dogs arriving then left last checkpoint #{last[0].dogs}"
      end
    end

    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        #format.html { redirect_to(@checkin, :notice => 'Checkin was successfully updated.') }
        #format.xml  { head :ok }
        format.html { redirect_to(:controller => :standings, :action => :index) }
        format.xml { redirect_to(:controller => :standings, :action => :index) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @checkin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.xml
  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy

    respond_to do |format|
      format.html { redirect_to(checkins_url) }
      format.xml  { head :ok }
    end
  end
end

