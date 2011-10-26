class LoginController < ApplicationController
  
  skip_before_filter :verify_authenticity_token ##, :only => [:index, :show]

	before_filter :except => :login do |controller|
	  controller.authorize({ "admin" => 1, "user" => 1, "view" => 1 })
  end
	layout :writers_and_readers

  def index
		@user = User.find(:all, :conditions => [ "id = ?", "#{session[:user_id]}"])
  end

  # just display the form and wait for user to
  # enter a name and password
  
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id]   = user.id
        session[:admin]     = user.access_level
        session[:email]     = user.email
        redirect_to(:action => "index")
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def add_user
    return if session[:admin] == nil
		if session[:admin] == "admin"
				@user = User.new(params[:user])
				if request.post? and @user.save
					flash.now[:notice] = "User #{@user.name} created"
					redirect_to(:action => :list_users)
				end
		else
			flash[:notice] = "You do not have access"
			session[:user_id] = nil
			redirect_to(:action => :login)
		end
  end
  
  def edit_user
    return if session[:admin] == nil
    @user = User.find(params[:id])
    if session[:admin] == 'admin'
      if @user
        if request.post? and @user.update_attributes(params[:user])
					flash.now[:notice] = "User #{@user.name} updates"
					redirect_to(:action => :list_users)
				end
			end
    end
  end

  def delete_user
    return if session[:admin] == nil
    ##
  	if session[:admin] == "admin"
			id = params[:id]
			if id && user = User.find(id)
				begin
				  if(user.name == 'admin')
				    flash[:notice] = "Admin can NOT be deleted"
				  else
					  user.destroy
					  flash[:notice] = "User #{user.name} deleted"
				  end
				rescue Exception => e
					flash[:notice] = e.message
				end
			end
			redirect_to(:action => :list_users)
		else
			flash[:notice] = "You do not have access"
			session[:user_id] = nil
			redirect_to(:action => :login)		
		end
  end

  def list_users
   return if session[:admin] == nil
  	if session[:admin] == "admin"
    	@all_users = User.find(:all)
    else
			flash[:notice] = "You do not have access"
			session[:user_id] = nil
			redirect_to(:action => :login)    
    end
  end

  def logout
    user = User.find(:all, :conditions => [ "id = ?", "#{session[:user_id]}"])
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end
      
end