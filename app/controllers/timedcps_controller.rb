class TimedcpsController < ApplicationController
  
  #before_filter :authorize, :except => :login
	before_filter :except => :login do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1 })
  end
	layout :writers_and_readers
	
  # GET /timedcps
  # GET /timedcps.xml
  def index
    @timedcps = Timedcp.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timedcps }
    end
  end

  # GET /timedcps/1
  # GET /timedcps/1.xml
  def show
    @timedcp = Timedcp.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timedcp }
    end
  end

  # GET /timedcps/new
  # GET /timedcps/new.xml
  def new
    timedcps = Timedcp.all
    if timedcps.length == 0
      @checkpoints = Checkpoint.all
      @timedcp = Timedcp.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @timedcp }
      end
    else
      redirect_to :action => "index"
      flash[:notice] = "Only one timed checkpoint can exist, delete and then add!"
    end
  end

  # GET /timedcps/1/edit
  def edit
    @checkpoints = Checkpoint.all
    @timedcp = Timedcp.find(params[:id])
  end

  # POST /timedcps
  # POST /timedcps.xml
  def create
    @timedcp = Timedcp.new(params[:timedcp])

    respond_to do |format|
      if @timedcp.save
        flash[:notice] = 'Timedcp was successfully created.'
        format.html { redirect_to(:controller => :timedcps, :action => :index) }
        format.xml { redirect_to(:controller => :timedcps, :action => :index) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timedcp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timedcps/1
  # PUT /timedcps/1.xml
  def update
    @timedcp = Timedcp.find(params[:id])

    respond_to do |format|
      if @timedcp.update_attributes(params[:timedcp])
        flash[:notice] = 'Timedcp was successfully updated.'
        format.html { redirect_to(:controller => :timedcps, :action => :index) }
        format.xml { redirect_to(:controller => :timedcps, :action => :index) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timedcp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timedcps/1
  # DELETE /timedcps/1.xml
  def destroy
    @timedcp = Timedcp.find(params[:id])
    @timedcp.destroy

    respond_to do |format|
      format.html { redirect_to(timedcps_url) }
      format.xml  { head :ok }
    end
  end
end
