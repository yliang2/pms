class User < ActiveRecord::Base
	has_secure_password

	validates_uniqueness_of :email, :name, on: :create
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates_format_of :password, with: /\A(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){6,40}\z/i, :message => "contains at least 6 characters (A-Z, 0-9)"
	validates_length_of :name, minimum: 3, maximum: 20

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!(:validate => false)
		UserMailer.password_reset(self).deliver_now
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def self.authenticate_password!(id, hours_of_expiration)
	    user = User.find_by_password_reset_token(id)
	    unless user && user.password_reset_sent_at >= hours_of_expiration.hours.ago
	      raise ActionController::RoutingError.new('Not Found') 
	    end		
	    user
	end

end
