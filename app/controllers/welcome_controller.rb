class WelcomeController < ApplicationController
	def index
		if !current_user
			render "welcome/index"
		else
			if current_user.role == "consumer"
				redirect_to deals_path
			end
		end
	end
end
