class AddVerifiedAndAvatarsToCompanies < ActiveRecord::Migration[5.2]
  def change
  	add_column :companies, :verified, :boolean, default: false
  	add_column :companies, :avatars, :json
  end
end
