class Post < ActiveRecord::Base
	validates :text, presence: true
	belongs_to :user
	has_many :comments, dependent: :destroy
end
