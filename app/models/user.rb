class User < ActiveRecord::Base
	
	validates :password, :email, :username, presence: true
	validates :password, length: {minimum: 6}
	validates :email, uniqueness: true

	has_many :posts, dependent: :destroy
	has_many :comments, through: :posts, source: :comments, dependent: :destroy

	has_many :followerships, 
		class_name: "Follower",
		foreign_key: :follower_id
		dependent: :destroy

	has_many :followeeships,
		class_name: "Follower",
		foreign_key: :followee_id
		dependent: :destroy

	has_many :followers,
		through: :followeeships
		source: :follower

	has_many :followees,
		through: :followerships,
		source: :followee
		
end
