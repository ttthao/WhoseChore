class User < ActiveRecord::Base
	has_one :profile
	before_create :build_profile #creates profile at user registration
	has_secure_password
	has_many :memberships
	has_many :groups, :through => :memberships
	has_many :chores

	def self.search(search)
  	if search
			where(["email LIKE ?", "%#{search}%"])
  	else
    	find_each
  	end
	end

end