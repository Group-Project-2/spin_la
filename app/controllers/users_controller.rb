class UsersController < Clearance::UsersController
	before_action :set_user, only: [:show, :edit, :update]

	def user_from_params
		email = user_params.delete(:email)
	  password = user_params.delete(:password)
	  last_name = user_params.delete(:last_name)
	  first_name = user_params.delete(:first_name)

		Clearance.configuration.user_model.new(user_params).tap do |user|
			user.email = email
			user.password = password
			user.last_name = last_name
			user.first_name = first_name
		end

	end

	def show
		
	end

	def edit
		
	end

	def update
		@user.update(user_params)
		redirect_to user_path(@user)
	end

	private

	def set_user
		@user = User.find(params[:id])
	end
		
	def user_params
		params.require(:user).permit(:email, :password, :first_name, :last_name, :profilepic)
	end
end
