class AddLosingdescriptionToDeals < ActiveRecord::Migration[5.2]
  def change
  	add_column :deals, :losing_description, :string, default: nil
  end
end
