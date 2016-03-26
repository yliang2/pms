require 'rails_helper'

RSpec.describe UserMailer do
	let(:user) {create(:user, :password_reset_token => "test")}
	let(:mail) {UserMailer.password_reset(user)}

	describe "#password_reset" do
		it "sends user password reset url" do
			expect(mail.subject).to eq("Password reset from PMS")
			expect(mail.to).to eq([user.email])
			expect(mail.from).to eq(["from@example.com"])			
		end

		it "renders the body" do
			user.send_password_reset
			expect(user.reload.password_reset_sent_at).to be_present
		end
	end
end