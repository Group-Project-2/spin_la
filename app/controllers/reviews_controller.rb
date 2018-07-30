class ReviewsController < ApplicationController
	before_action :find_company, only: [:new, :create]
	before_action :find_review, only: [:report, :destroy]

	def index
		@reviews = Review.find_by(company_id: params[:id])
	end

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.company_id = params[:company_id]
		
		if @review.save
			user = User.find(@review.user.id)
			user.update(review_count: user.review_count += 1)

				#Logic to award 2 spins on every 5th review
				if user.review_count % 5 == 0
					user.update(spins_remaining: user.spins_remaining += 2)
					#Alert that user has won 2 free spins (WIP)
				end
			#Alert review has been saved (WIP)
			redirect_to public_path(@company)
		else
			#Alert review not saved (WIP)
		end
	end

	def report
		if @review.reported == false
			@review.update(reported: true, reported_by_user_id: current_user.id)
			# Alert user that this review has been reported to admin. When admin approves, get free spin.
			respond_to do |format|
					format.js
				end
		else
			# Alert review has already been reported to admin before. 
			respond_to do |format|
					format.js
				end
		end
	end

	#This is confined to admin only
	def destroy
		# Assign free spin to user who reported toxic review
		user = User.find(@review.reported_by_user_id)
		user.update(spins_remaining: user.spins_remaining += 1)

		# Happens after free spin given
		@review.destroy
		redirect_to admins_path
	end

	private

	def find_company
		@company = Company.find(params[:company_id])
	end

	def find_review
		@review = Review.find(params[:id])
	end

	def review_params
		params.require(:review).permit(:title, :description, :stars)
	end 

end
