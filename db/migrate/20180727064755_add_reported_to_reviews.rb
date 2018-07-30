class AddReportedToReviews < ActiveRecord::Migration[5.2]
  def change
  	add_column :reviews, :reported, :boolean, default: false
  	add_column :reviews, :reported_by_user_id, :integer
  end
end
