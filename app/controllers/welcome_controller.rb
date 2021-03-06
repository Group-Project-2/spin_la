class WelcomeController < ApplicationController
	def index
		@deals = Deal.all

		if !current_user
			render "welcome/index"
		else
			if current_user.role == "consumer"
				redirect_to deals_path
			elsif current_user.role == "business"
				@company = Company.find_by(user_id: current_user.id)
				redirect_to company_path(@company)
			else
				redirect_to admins_path
			end
		end
	end
end
