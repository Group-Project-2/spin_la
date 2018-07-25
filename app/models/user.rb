class User < ApplicationRecord
	include Clearance::User
 	has_many :authentications, dependent: :destroy
 	has_many :deals
 	enum role: {consumer: 0, business: 1, admin: 2}


 	validates :email,
				 		presence: { message: "Email must not be blank."},
	          format: { with: /\w+@\w+\.\w{2,}/, message: "Email must be in format abc@example.com"}

	validates :password,
						on: :create,
           presence: { message: "Password must not be blank."},
           length: { minimum: 8 }


	          

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
