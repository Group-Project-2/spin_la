class AddReportedToReviews < ActiveRecord::Migration[5.2]
  def change
  	add_column :reviews, :reported, :boolean, default: false
  end
end
