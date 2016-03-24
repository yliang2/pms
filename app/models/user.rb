class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :password, :on => :create
	validates_presence_of :email, :name
	validates_uniqueness_of :email, :name
end
