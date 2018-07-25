class Company < ApplicationRecord
	has_many :deals, dependent: :destroy
	belongs_to :user
	# mount_uploaders :avatars, AvatarUploader
end
