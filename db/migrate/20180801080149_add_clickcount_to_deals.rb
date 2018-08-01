class AddClickcountToDeals < ActiveRecord::Migration[5.2]
  def change
  	add_column :deals, :click_count, :integer, default: 0
  end
end
