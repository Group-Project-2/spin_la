class Review < ApplicationRecord
	validates :title, presence: true
	validates :description, presence: true
	validates :stars, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5,  only_integer: true }

	belongs_to :user
	belongs_to :company
end
