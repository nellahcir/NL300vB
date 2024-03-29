class CheckpointsController < ApplicationController
  # GET /checkpoints
  # GET /checkpoints.xml
  
  #before_filter :authorize, :except => :login
	before_filter :except => [ :login, :index ] do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1 })
  end
	layout :writers_and_readers
	
  def index
    @checkpoints = Checkpoint.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checkpoints }
    end
  end

  # GET /checkpoints/1
  # GET /checkpoints/1.xml
  def show
    @checkpoint = Checkpoint.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @checkpoint }
    end
  end

  # GET /checkpoints/new
  # GET /checkpoints/new.xml
  def new
    @checkpoint = Checkpoint.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @checkpoint }
    end
  end

  # GET /checkpoints/1/edit
  def edit
    @checkpoint = Checkpoint.find(params[:id])
  end

  # POST /checkpoints
  # POST /checkpoints.xml
  def create
    @checkpoint = Checkpoint.new(params[:checkpoint])
    nextSeq = Checkpoint.getNextSeq()
    @checkpoint.sequence = nextSeq
    respond_to do |format|
      if @checkpoint.save
        format.html { redirect_to(:action => :index) }
        format.xml { redirect_to(:action => :index) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @checkpoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /checkpoints/1
  # PUT /checkpoints/1.xml
  def update
    @checkpoint = Checkpoint.find(params[:id])
    respond_to do |format|
      if @checkpoint.update_attributes(params[:checkpoint])
        ##format.html { redirect_to(@checkpoint, :notice => 'Checkpoint was successfully updated.') }
        ##format.xml  { head :ok }
        format.html { redirect_to(:action => :index) }
        format.xml { redirect_to(:action => :index) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @checkpoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /checkpoints/1
  # DELETE /checkpoints/1.xml
  def destroy
    checkins = Checkin.all
    checkouts = Checkout.all
    if((checkins.length == 0) and (checkouts.length ==0))
      @checkpoint = Checkpoint.find(params[:id])
      @checkpoint.destroy
      respond_to do |format|
        format.html { redirect_to(checkpoints_url) }
        format.xml  { head :ok }
      end
    else
      flash[:notice] = "Can not delete checkpoint when checkins or checkouts exist!"
      redirect_to(checkpoints_url)
    end
  end
  
end # <--- end class