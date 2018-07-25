class CompaniesController < ApplicationController
	before_action :find_company, only: [:show, :public, :verify]

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

	def show

	end

	def public

	end

	def verify
		if @company.verified == true
			@company.update(verified: false)
			respond_to do |format|
					format.js
				end
		else
			@company.update(verified: true)
			respond_to do |format|
					format.js
				end
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

