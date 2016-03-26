class PasswordResetsController < ApplicationController
  skip_before_action :authenticate	
  def new
  end

  def create
    @user = User.find_by_email(password_reset_params[:email])
    if @user
      @user.send_password_reset
  	  redirect_to root_path, :notice => "Email sent with password reset instructions."
    else
      redirect_to new_password_resets_path, :notice => "Invaild email address. Please enter a vaild email address!"
    end
  end

  private

  def password_reset_params
  	params.permit(:email)
  end
end
