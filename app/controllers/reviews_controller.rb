class ReviewsController < ApplicationController

	def index
		@reviews = Review.find_by(company_id: params[:id])
	end

	def new
		@review = Review.new
		@company = Company.find(params[:company_id])
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.company_id = params[:company_id]
		
		if @review.save
			#Alert review has been saved
			redirect_to root_path
		else
			#What happens
		end
	end

	#This is confined to admin only
	def destroy
		@review = Review.find(params[:id])
		@review.destroy
	end

	private

	def review_params
		params.require(:review).permit(:title, :description, :stars)
	end 

end
