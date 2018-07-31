class AddImageToDeals < ActiveRecord::Migration[5.2]
  def change
  	add_column :deals, :deal_image, :string
  end
end
