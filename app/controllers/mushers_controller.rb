class MushersController < ApplicationController
  
  #before_filter :authorize, :except => :login
  before_filter :except => :login do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1 })
  end
	layout :writers_and_readers
	
  # GET /mushers
  # GET /mushers.xml
  def index
    @statuses = Status.all
    if params[:order] == 'bib'
      @mushers = Musher.find(:all, :order => 'bibnum')
    elsif params[:order] == 'stpos'
      @mushers = Musher.find(:all, :order => 'stpos')
    else
      @mushers = Musher.find(:all, :order => 'name')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mushers }
    end
  end

  # GET /mushers/1
  # GET /mushers/1.xml
  def show
    @statuses = Status.all
    @musher = Musher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @musher }
    end
  end

  # GET /mushers/new
  # GET /mushers/new.xml
  def new
    @statuses = Status.all
    @musher = Musher.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @musher }
    end
  end

  # GET /mushers/1/edit
  def edit
    @statuses = Status.all
    @musher = Musher.find(params[:id])
  end

  # POST /mushers
  # POST /mushers.xml
  def create
    @statuses = Status.all
    @musher = Musher.new(params[:musher])

    respond_to do |format|
      if @musher.save
        ##format.html { redirect_to(@musher, :notice => 'Musher was successfully created.') }
        ##format.xml  { render :xml => @musher, :status => :created, :location => @musher }
        format.html { redirect_to(:action => :index) }
        format.xml { redirect_to(:action => :index) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @musher.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mushers/1
  # PUT /mushers/1.xml
  def update
    @statuses = Status.all
    @musher = Musher.find(params[:id])

    respond_to do |format|
      if @musher.update_attributes(params[:musher])
        ##format.html { redirect_to(@musher, :notice => 'Musher was successfully updated.') }
        ##format.xml  { head :ok }
        format.html { redirect_to(:action => :index) }
        format.xml { redirect_to(:action => :index) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @musher.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mushers/1
  # DELETE /mushers/1.xml
  def destroy
    @statuses = Status.all
    @musher = Musher.find(params[:id])
    checkins = Checkin.find(:all, :conditions => "musher_id = #{@musher.id}")
    checkouts = Checkout.find(:all, :conditions => "musher_id = #{@musher.id}")
    if checkins.length == 0 and checkouts.length == 0
      @musher.destroy
    else
      flash[:notice] = "MUST remove checkins & checkouts prior to deleting musher"
    end

    respond_to do |format|
      format.html { redirect_to(mushers_url) }
      format.xml  { head :ok }
    end
  end
end
