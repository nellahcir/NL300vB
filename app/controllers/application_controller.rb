# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  ## dep filter_parameter_logging :password

  # Scrub sensitive parameters from your log
  ## depfilter_parameter_logging :password
  
  def authorize(levels)
    if not levels.has_key?("public")
      unless User.find_by_id(session[:user_id]) and levels.has_key?(session[:admin])
        flash[:notice] = "Please log in"
        redirect_to(:controller => "login", :action => "login")
      end
    end
  end
  
  def sort_order(default)
    "#{(params[:c] || default.to_s).gsub(/[\s;'\"]/,'')} #{params[:d] == 'down' ? 'DESC' : 'ASC'}"
  end
  
  def writers_and_readers
  	if session[:user_id].nil?
  		return "public"
  	end
  	user = User.find(:all, :conditions => "id = #{session[:user_id]}")
  	if user[0].access_level == "admin"
  		return "admin"
  	end
  	if user[0].access_level == "user"
  		return "user"
  	end
  	if user[0].access_level == "view"
  		return "view"
  	end
  end


end
