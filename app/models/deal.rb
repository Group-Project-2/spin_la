class Deal < ApplicationRecord
	belongs_to :company
	mount_uploader :deal_image, DealimageUploader
end
