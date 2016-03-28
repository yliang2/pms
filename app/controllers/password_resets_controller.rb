class PasswordResetsController < ApplicationController
  skip_before_action :authenticate	
  def new
  end

  def create
    @user = User.find_by_email(id_param[:email])
    if @user
      @user.send_password_reset
  	  redirect_to root_path, :notice => "Email sent with password reset instructions."
    else
      redirect_to new_password_reset_path, :notice => "Invaild email address. Please enter a vaild email address!"
    end
  end

  def edit
    @user = User.find_by_password_reset_token(id_param[:id])
    unless @user
      raise ActionController::RoutingError.new('Not Found') 
    end
  end

  def update
    @user = User.find_by_password_reset_token(id_param[:id])
    if @user.password_reset_sent_at < 2.hours.ago
       redirect_to new_password_reset_path, :alert => "Password update time has expired!"
    elsif @user.update(password_update_params)
      redirect_to root_path, :notice => "Password update successful!"
    else 
      redirect_to edit_password_reset_path, :notice => "Password update fail!"
    end
  end

  private
    def id_param
    	params.permit(:id, :email)
    end

    def password_update_params
      params.require(:user).permit(:password, :password_confirmation)
    end    
end
