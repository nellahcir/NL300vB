class UpdatesController < ApplicationController
  
  before_filter :except => :login do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1 })
  end
	layout :writers_and_readers
	
  # GET /updates
  # GET /updates.xml
  def index
    @mushers = Musher.all
    @checkpoints = Checkpoint.all
    @updates = Update.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @updates }
    end
  end

  # GET /updates/1
  # GET /updates/1.xml
  def show
    @update = Update.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @update }
    end
  end

  # GET /updates/new
  # GET /updates/new.xml
  def new
    @mushers = Musher.all
    sM = Musher.new
    sM.name = "_select_musher"
    @mushers.unshift(sM)
    @checkpoints = Checkpoint.all
    @update = Update.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @update }
    end
  end

  # GET /updates/1/edit
  def edit
    @mushers = Musher.all
    @checkpoints = Checkpoint.all
    @update = Update.find(params[:id])
  end

  # POST /updates
  # POST /updates.xml
  def create
    @mushers = Musher.all
    @checkpoints = Checkpoint.all
    @update = Update.new(params[:update])
    
    if params[:update][:dogsin]
      respond_to do |format|
        @update.timeout = ""
        if @update.save
          format.html { redirect_to(@update, :notice => 'Update was successfully created.') }
          format.xml  { render :xml => @update, :status => :created, :location => @update }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @update.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @updateOUT = Update.find(:all, :conditions => "musher_id = #{@update.musher_id} and
          checkpoint_id = #{@update.checkpoint_id}")
        if @updateOUT.save
          format.html { redirect_to(@update, :notice => 'Update was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @updateOUT.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /updates/1
  # PUT /updates/1.xml
  def update
    ##@mushers = Musher.all
    ##@checkpoints = Checkpoint.all
    @update = Update.find(params[:id])

    respond_to do |format|
      if @update.update_attributes(params[:update])
        format.html { redirect_to(@update, :notice => 'Update was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @update.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /updates/1
  # DELETE /updates/1.xml
  def destroy
    @update = Update.find(params[:id])
    @update.destroy

    respond_to do |format|
      format.html { redirect_to(updates_url) }
      format.xml  { head :ok }
    end
  end
  
  def musher_select_checkpoint
    musher = Musher.find(params[:update_musher_id])
    lastUpdateRowID = Update.find_last_update(musher.id)
    lastUpdateRow = Update.find(lastUpdateRowID[0])
    if lastUpdateRow.timeout.blank?
      # this update will be checkout
      @checkpoints = Checkpoint.find(:all, :conditions => "id = #{lastUpdateRow.checkpoint_id}")
      @dir = "out"
    else
      # we need a new update row for checkin
      @checkpoints = Checkpoint.find(:all, :conditions => "id = #{lastUpdateRow.checkpoint_id} + 1")
      @dir = "in"
    end
    respond_to do |format|
      format.js  
    end
  end
  
end
