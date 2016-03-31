class UsersController < ApplicationController
	before_action :admin_permitted
	def index
	end

	def show

	end

	def new
		@user = User.new
	end

	def edit
		@user = current_user #User.find_by_id(current_user.id)
	end

	def update
		@user = current_user
		@user.update(user_params)
		if @user.save
			redirect_to root_path, :notice => "Update successful!"
		else
			render "edit", :noitce => "Update faile!"
		end	
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to login_path, :notice => "Signed up!"
		else
			render "new", :notice => "Invaild input!"
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
