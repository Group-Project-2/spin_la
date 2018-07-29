class UsersController < Clearance::UsersController

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
		@user = User.find(params[:id])
	end

	# private
	# def user_params
	# 	params.require(:user).permit(:email, :password, :first_name, :last_name)
	# end
end
