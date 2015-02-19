class Restaurant < ActiveRecord::Base

	belongs_to :user
	has_many :reviews, dependent: :destroy
	validates :name, length: {minimum: 2}, uniqueness: true

end
