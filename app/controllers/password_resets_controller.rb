class PasswordResetsController < ApplicationController
  before_action :admin_permitted
  def new
  end

  def create
    @user = User.find_by_email(id_param[:email])
    if @user
      @user.send_password_reset
  	  redirect_to login_path, :notice => "Email sent with password reset instructions."
    else
      redirect_to new_password_reset_path, :notice => "Invaild email address. Please enter a vaild email address!"
    end
  end

  def edit
    @user = User.authenticate_password!(id_param[:id], 2)
  end

  def update
    @user = User.authenticate_password!(id_param[:id], 2)
    if @user.update(password_update_params)
      redirect_to login_path, :notice => "Password update successful!"
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
