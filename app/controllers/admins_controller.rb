class AdminsController < ApplicationController
	def index
		@companies = Company.all
	end

	def destroy
		@company = Company.find(params[:id])
		@company.delete

		redirect_to admins_path
	end
end
