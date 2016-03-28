class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :password, :confirmation => true, :on => :create
	validates_presence_of :email, :name
	validates_uniqueness_of :email, :name
	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver_now
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end
end
