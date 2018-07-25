class Company < ApplicationRecord
	has_many :deals
	belongs_to :user
	# mount_uploaders :avatars, AvatarUploader
end
