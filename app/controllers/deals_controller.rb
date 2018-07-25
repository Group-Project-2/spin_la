class DealsController < ApplicationController

	def index
	end

	def new
		@deal = Deal.new
	end

	def create
		@deal = Deal.new(deal_params)
		@company = Company.find_by(user_id: current_user.id)
		@deal.company_id = @company.id

		if @deal.save
			redirect_to company_path(@company)
		else
			redirect_back
		end
	end

	private

	def deal_params
		params.require(:deal).permit(:wins_remaining, :odds_numerator, :odds_denominator, :description)
	end

end
