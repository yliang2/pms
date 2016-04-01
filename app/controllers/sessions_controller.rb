class SessionsController < ApplicationController
  skip_before_action :authenticate
  def new
  end

  def create
  	@user = User.find_by_name(params[:name])
  	if @user && @user.authenticate(params[:password])
  		redirect_to user_path(@user), :notice => current_user.nil? ? "" : "#{current_user.name} logged out!"
      reset_current_user(@user)
  	else
  		redirect_to login_path, :notice => "Wrong username or password"
  	end
  end

  def destroy
    if current_user.nil?
      redirect_to login_path, :notice => "logged out!"
    else
      redirect_to login_path, :notice => "#{current_user.name} logged out!"
    end
    reset_current_user(nil)
  end

  private

  def reset_current_user(user)
    session[:user_id] = user.nil? ? nil : user.id 
    @current_user = nil
    current_user
  end
end
