class AddProfilepicAndReviewcountToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :profilepic, :string
  	add_column :users, :review_count, :integer, default: 0
  end
end
