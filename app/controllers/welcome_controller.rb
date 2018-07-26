class WelcomeController < ApplicationController
	def index
		if !current_user
			render "welcome/index"
		else
			if current_user.role == "consumer"
				redirect_to deals_path
			elsif current_user.role == "business"
				@company = Company.find_by(user_id: current_user.id)
				redirect_to company_path(@company)
			end
		end
	end
end
