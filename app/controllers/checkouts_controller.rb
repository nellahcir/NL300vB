class CheckoutsController < ApplicationController
  
  #before_filter :authorize, :except => :login
  before_filter :except => :login do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1, "view" => 1 })
  end
	layout :writers_and_readers
	
  # GET /checkouts
  # GET /checkouts.xml
  def index
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    if params[:search] and params[:search] != "" then
      musher = Musher.find(:all, :conditions => "bibnum = #{params[:search]}")
      @checkouts = Checkout.find(:all, :conditions => "musher_id = #{musher[0].id}")
    else
      @checkouts = Checkout.paginate(:page => params[:page], :per_page => 25, :order => 'time DESC')
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checkouts }
    end
  end

  # GET /checkouts/1
  # GET /checkouts/1.xml
  def show
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkout = Checkout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @checkout }
    end
  end

  # GET /checkouts/new
  # GET /checkouts/new.xml
  def new
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkout = Checkout.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @checkout }
    end
  end

  # GET /checkouts/1/edit
  def edit
    flash.discard
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkout = Checkout.find(params[:id])
  end

  # POST /checkouts
  # POST /checkouts.xml
  def create
    bad = false
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkout = Checkout.new(params[:checkout])
    if @checkout.musher.status.proceed
      last = Checkin.find(:all, :conditions => "musher_id = #{@checkout.musher_id} and checkpoint_id = #{@checkout.checkpoint_id}")
      if not last.empty? then
        if @checkout.time < last[0].time then
          flash[:notice] = "Leaving before arriving from checkpoint! #{last[0].time}"
          bad = true
        end
        if @checkout.dogs.nil?
          flash[:notice] = "Dog count can NOT be blank"
        elsif @checkout.dogs > last[0].dogs then 
          flash[:notice] = "More dogs leaving then came in #{last[0].dogs}"
        end
      else
        flash[:notice] = "Warning: no checkin for musher #{@checkout.musher.name} at #{@checkout.checkpoint.name}"
      end
      respond_to do |format|
        if not bad
          if (@checkout.save)
            format.html { redirect_to(:controller => :standings, :action => :index) }
            format.xml { redirect_to(:controller => :standings, :action => :index) }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @checkout.errors, :status => :unprocessable_entity }
          end
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @checkout.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "Musher is NOT clear to proceed in race."
      redirect_to(:controller => :standings, :action => :index)
    end
  end

  # PUT /checkouts/1
  # PUT /checkouts/1.xml
  def update
    @mushers = Musher.find(:all, :order => 'bibnum')
    @checkpoints = Checkpoint.find(:all, :order => 'sequence')
    @checkout = Checkout.find(params[:id])
    
    last = Checkin.find(:all, :conditions => "musher_id = #{@checkout.musher_id} and checkpoint_id = #{@checkout.checkpoint_id}")
    if not last.empty? then
      if @checkout.time < last[0].time then
        flash[:notice] = "Leaving before arriving from checkpoint! #{last[0].time}"
      end
      if @checkout.dogs > last[0].dogs then 
        flash[:notice] = "More dogs leaving then came in #{last[0].dogs}"
      end
    else
      flash[:notice] = "Warning: no checkin for musher #{@checkout.musher.name} at #{@checkout.checkpoint.name}"
    end

    respond_to do |format|
      if @checkout.update_attributes(params[:checkout])
        format.html { redirect_to(:action => :index) }
        format.xml { redirect_to(:action => :index) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @checkout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1
  # DELETE /checkouts/1.xml
  def destroy
    @checkout = Checkout.find(params[:id])
    @checkout.destroy

    respond_to do |format|
      format.html { redirect_to(checkouts_url) }
      format.xml  { head :ok }
    end
  end
end
