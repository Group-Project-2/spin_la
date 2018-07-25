class User < ApplicationRecord
	include Clearance::User
 	has_many :authentications, dependent: :destroy

 	validates :email,
				 		presence: { message: "Email must not be blank."},
	          format: { with: /\w+@\w+\.\w{2,}/, message: "Email must be in format abc@example.com"} 
	validates :password,
				 		length: { minimum: 8, message: "Password must be at least 8 characters." }

	def self.create_with_auth_and_hash(authentication, auth_hash)
		user = self.create!(
		 first_name: auth_hash["info"]["given_name"],
		 last_name: auth_hash["info"]["family_name"],
		 email: auth_hash["info"]["email"],
		 password: SecureRandom.hex(10)
		)
		user.authentications << authentication
		return user
	end

	# grab google to access google for user data
	def google_token
		x = self.authentications.find_by(provider: 'google_oauth2')
		return x.token unless x.nil?
	end
end
