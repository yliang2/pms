class SessionsController < ApplicationController
  skip_before_action :authenticate
  def new
  end

  def create
  	@user = User.find_by_name(params[:name])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect_to root_url, :notice => "You are login as:#{@user.name}"
  	else
  		redirect_to login_path, :notice => "Wrong username or password"
  	end
  end

  def destroy
  end
end
