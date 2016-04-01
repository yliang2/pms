class UsersController < ApplicationController
	before_action :admin_permitted, only: [:new, :creat]
	before_action :owner_permitted
	def index
	end

	def show
		@user = User.find_by_id(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find_by_id(params[:id])
	end

	def update
		@user = User.find_by_id(params[:id])
		@user.update(user_params)
		if @user.save
			redirect_to user_path(@user), :notice => "Update successful!"
		else
			render "edit", :noitce => "Update fail!"
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

		def owner_permitted
			unless current_user && (current_user.id.to_i == params[:id].to_i || current_user.admin?)
				flash[:notice] = "Only owner or admin permitted!" 
				redirect_to login_path
			end				
		end
end
