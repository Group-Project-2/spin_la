class ReviewsController < ApplicationController
	before_action :find_company, only: [:new, :create]

	def index
		@reviews = Review.find_by(company_id: params[:id])
	end

	def new
		@review = Review.new
		# @company = Company.find(params[:company_id])
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.company_id = params[:company_id]
		# @company = Company.find(params[:company_id])
		
		if @review.save
			#Alert review has been saved
			redirect_to public_path(@company)
		else
			#Alert review not saved
		end
	end

	def report
		@review = Review.find(params[:id])

		if @review.reported == false
			@review.update(reported: true)
			# Alert user that this review has been reported to admin.
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
		@review = Review.find(params[:id])
		@review.destroy
	end

	private

	def find_company
		@company = Company.find(params[:company_id])
	end

	def review_params
		params.require(:review).permit(:title, :description, :stars)
	end 

end
