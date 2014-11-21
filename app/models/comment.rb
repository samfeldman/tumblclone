class Comment < ActiveRecord::Base
	validates :product_id, :user_id, :text, presence: true

	belongs_to :post
	belongs_to :user
end
