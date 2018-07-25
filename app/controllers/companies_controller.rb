class CompaniesController < ApplicationController
	def new
		@company = Company.new
	end

	def create
		@company = Company.new(listing_params)
		@company.user_id = current_user.id

		if @company.save
		
			current_user.update(role: 1)
			redirect_to company_path(@company)
		else
			redirect_back
		end
	end

	private
	def find_company
		@company = Company.find(params[:id])
	end

	def listing_params
		params.require(:company).permit(:name, :description, :address, :email, :phone_number)
	end
end

