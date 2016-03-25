require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) {create(:user)}

	describe "#send_password_reset" do
		it "generate an unique password_reset_token for each password reset" do
			user.send_password_reset
			last_token = user.password_reset_token
			user.send_password_reset
			expect(user.password_reset_token).to_not eq(last_token)
		end

		it "save the time when password reset was sent" do
			user.send_password_reset
			expect(user.reload.password_reset_sent_at).to be_present
		end

		it "deliver email to user" do
			user.send_password_reset
			expect(last_email.to).to include(user.email)
		end
	end
end
