class DealsController < ApplicationController
	before_action :find_deal, only: [:show, :spin, :edit, :update, :destroy]

	def index
		@user = current_user
		@deals = Deal.all
	end

	def new
		@deal = Deal.new
	end

	def spin_type
		@deal = Deal.new

		respond_to do |format|
			format.js
		end
	end

	def regular_type
		@deal = Deal.new

		respond_to do |format|
			format.js
		end
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
	end

	def spin
		
		@win_odds = ((@deal.odds_numerator.to_f)/(@deal.odds_denominator.to_f))*100

		if @deal.odds_numerator == 314159265 && @deal.odds_denominator == 314159265
			if @deal.wins_remaining > 0
				if current_user.deals_won.include?(@deal.id)
					flash.now[:notice] = "You have already claimed this deal before!"
				else
					@deal.update(click_count: @deal.click_count += 1)
					@deal.update(wins_remaining: @deal.wins_remaining -= 1)
					current_user.update(deals_won: current_user.deals_won << @deal.id)
					flash.now[:success] = "Congratulations, you have won #{@deal.description}!"
				end
			else @deal.wins_remaining == 0
				flash.now[:notice] = "This deal has unfortunately ran out!"
			end
		else
			if @deal.wins_remaining > 0
				@deal.update(click_count: @deal.click_count += 1)
				if current_user.spins_remaining != 0
					current_user.update(spins_remaining: current_user.spins_remaining -= 1)
					# logiclogiclogic
					case rand (100)+1
						when 1..@win_odds
							@deal.update(wins_remaining: @deal.wins_remaining -= 1)
							current_user.update(deals_won: current_user.deals_won << @deal.id)
							#Alert user they won
							flash.now[:success] = "Congratulations, you have won #{@deal.description}!"
						when @win_odds..100
							if @deal.losing_description == "" || @deal.losing_description == nil
							flash.now[:error] = "Boo! You are not in luck!"
							else
							flash.now[:error] = "You did not win, but at least you got #{@deal.losing_description}"
							end
					end
				elsif current_user.spins_remaining == 0
				   flash.now[:alert] = "Boo! No more spins available!"
				end
			else @deal.wins_remaining == 0
				flash.now[:notice] = "This deal has unfortunately ran out!"
			end
		end
		respond_to do |format|
			format.js
		end
	end

	def wheelspin
		respond_to do |format|
			format.json
		end
	end

	def destroy	
		@deal.destroy
  	redirect_to root_path
	end

	private
	def find_deal
		@deal = Deal.find(params[:id])
	end

	def deal_params
		params.require(:deal).permit(:wins_remaining, :odds_numerator, :odds_denominator, :description, :deal_image, :losing_description)
	end
end
