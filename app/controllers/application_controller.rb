class ApplicationController < ActionController::Base
  before_action :authenticate
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :admin_permitted

  private
  	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end

  	def authenticate
  		unless session[:user_id]
  			redirect_to login_path
  		else
  			current_user
  		end
  	end

    def admin_permitted
      unless current_user && current_user.admin?
        redirect_to login_path, :notice => "Only admin permitted!" 
       end 
    end     
end
