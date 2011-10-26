class CompleQueriesController < ApplicationController
  
  before_filter :except => :login do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1 })
  end
	layout :writers_and_readers
	
  # GET /comple_queries
  # GET /comple_queries.xml
  def index
    @comple_queries = CompleQueries.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comple_queries }
    end
  end

  # GET /comple_queries/1
  # GET /comple_queries/1.xml
  def show
    @comple_queries = CompleQueries.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comple_queries }
    end
  end

  # GET /comple_queries/new
  # GET /comple_queries/new.xml
  def new
    @comple_queries = CompleQueries.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comple_queries }
    end
  end

  # GET /comple_queries/1/edit
  def edit
    @comple_queries = CompleQueries.find(params[:id])
  end

  # POST /comple_queries
  # POST /comple_queries.xml
  def create
    @comple_queries = CompleQueries.new(params[:comple_queries])

    respond_to do |format|
      if @comple_queries.save
        flash[:notice] = 'CompleQueries was successfully created.'
        format.html { redirect_to(@comple_queries) }
        format.xml  { render :xml => @comple_queries, :status => :created, :location => @comple_queries }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comple_queries.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comple_queries/1
  # PUT /comple_queries/1.xml
  def update
    @comple_queries = CompleQueries.find(params[:id])

    respond_to do |format|
      if @comple_queries.update_attributes(params[:comple_queries])
        flash[:notice] = 'CompleQueries was successfully updated.'
        format.html { redirect_to(@comple_queries) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comple_queries.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comple_queries/1
  # DELETE /comple_queries/1.xml
  def destroy
    @comple_queries = CompleQueries.find(params[:id])
    @comple_queries.destroy

    respond_to do |format|
      format.html { redirect_to(comple_queries_url) }
      format.xml  { head :ok }
    end
  end
end
