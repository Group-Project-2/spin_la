class DealsController < ApplicationController

	def index
		@user = current_user
		@deals = Deal.all
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

	def show
		@deal = Deal.find(params[:id])
	end

	def spin
		@deal = Deal.find(params[:id])
		@win_odds = ((@deal.odds_numerator.to_f)/(@deal.odds_denominator.to_f))*100

		if current_user.spins_remaining != 0
			current_user.update(spins_remaining: current_user.spins_remaining -= 1)
		
			# logiclogiclogic
			case rand (100)+1
				when 1..@win_odds
					@deal.update(wins_remaining: @deal.wins_remaining -= 1)
					current_user.update(deals_won: current_user.deals_won << @deal.id)
					#Alert user they won
				when @win_odds..100
					#Alert user they lost
			end
	
			respond_to do |format|
				format.js
			end
		elsif current_user.spins_remaining == 0
		   flash[:alert] = "Boo! No more spins available!"
		   respond_to do |format|
				format.js
			end
		end
	end

	private


	def deal_params
		params.require(:deal).permit(:wins_remaining, :odds_numerator, :odds_denominator, :description)
	end

end
