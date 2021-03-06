class User < ActiveRecord::Base
	
	validates :password, :email, :username, presence: true
	validates :password, confirmation: true
	validates :password, length: {minimum: 6}
	validates :email, uniqueness: true

	has_many :posts, dependent: :destroy
	has_many :comments, through: :posts, source: :comments, dependent: :destroy

	has_many :followerships, 
		class_name: "Follower",
		foreign_key: :follower_id,
		dependent: :destroy

	has_many :leaderships,
		class_name: "Follower",
		foreign_key: :leader_id,
		dependent: :destroy

	has_many :followers,
		through: :leaderships,
		source: :follower

	has_many :leaders,
		through: :followerships,
		source: :leader
		
end
