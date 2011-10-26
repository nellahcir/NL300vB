class AccesslevelsController < ApplicationController
  
  before_filter :except => :login do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1 })
  end
	layout :writers_and_readers
	
  # GET /accesslevels
  # GET /accesslevels.xml
  def index
    @accesslevels = Accesslevel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accesslevels }
    end
  end

  # GET /accesslevels/1
  # GET /accesslevels/1.xml
  def show
    @accesslevel = Accesslevel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @accesslevel }
    end
  end

  # GET /accesslevels/new
  # GET /accesslevels/new.xml
  def new
    @accesslevel = Accesslevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @accesslevel }
    end
  end

  # GET /accesslevels/1/edit
  def edit
    @accesslevel = Accesslevel.find(params[:id])
  end

  # POST /accesslevels
  # POST /accesslevels.xml
  def create
    @accesslevel = Accesslevel.new(params[:accesslevel])

    respond_to do |format|
      if @accesslevel.save
        flash[:notice] = 'Accesslevel was successfully created.'
        format.html { redirect_to(@accesslevel) }
        format.xml  { render :xml => @accesslevel, :status => :created, :location => @accesslevel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @accesslevel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accesslevels/1
  # PUT /accesslevels/1.xml
  def update
    @accesslevel = Accesslevel.find(params[:id])

    respond_to do |format|
      if @accesslevel.update_attributes(params[:accesslevel])
        flash[:notice] = 'Accesslevel was successfully updated.'
        format.html { redirect_to(@accesslevel) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @accesslevel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /accesslevels/1
  # DELETE /accesslevels/1.xml
  def destroy
    @accesslevel = Accesslevel.find(params[:id])
    @accesslevel.destroy

    respond_to do |format|
      format.html { redirect_to(accesslevels_url) }
      format.xml  { head :ok }
    end
  end
end

=begin
user = User.find(:all, :conditions => [ "id = ?", "#{session[:user_id]}"])
=end
