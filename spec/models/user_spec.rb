require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each){ @user = build(:user,:password_reset_token => "test_pws_reset_token", :password_reset_sent_at => DateTime.now)}  

	describe "#validate input formats" do
		it "checks email format" do
			@user.email = ""
			@user.save
			expect(@user.errors.size).to eq(2)
			@user.email = "abc"
			@user.save
			expect(@user.errors.size).to eq(1)
			@user.email = "abc@abc"
			@user.save
			expect(@user.errors.size).to eq(1)
			@user.email = "abc@abc.com"
			@user.save
			expect(@user.errors.size).to eq(0)			
		end

		it "checks @user name length" do
			@user.name = ""
			@user.save
			expect(@user.errors.size).to eq(2)
			@user.name = "ac"
			@user.save
			expect(@user.errors.size).to eq(1)
			@user.name ="abcabcabcabasfassdfes"
			@user.save
			expect(@user.errors.size).to eq(1)
			@user.name ="abcabc"
			@user.save
			expect(@user.errors.size).to eq(0)
		end	

		it "checks password format" do
			@user.password = ""
			@user.password_confirmation = ""
			@user.save			
			expect(@user.errors.size).to eq(2)			
			@user.password = "a234c"
			@user.password_confirmation = @user.password
			@user.save			
			expect(@user.errors.size).to eq(1)			
			@user.password ="aaaaaaa"
			@user.password_confirmation = @user.password
			@user.save			
			expect(@user.errors.size).to eq(1)			
			@user.password ="1234567"
			@user.password_confirmation = @user.password
			@user.save			
			expect(@user.errors.size).to eq(1)			
			@user.password ="1234d6"
			@user.password_confirmation = @user.password
			@user.save			
			expect(@user.errors.size).to eq(0)			

		end	

	end

	describe "#send_password_reset" do
		it "generate an unique password_reset_token for each password reset" do
			@user.send_password_reset
			last_token = @user.password_reset_token
			@user.send_password_reset
			expect(@user.password_reset_token).to_not eq(last_token)
		end

		it "save the time when password reset was sent" do
			@user.send_password_reset
			expect(@user.reload.password_reset_sent_at).to be_present
		end

		it "deliver email to @user" do
			@user.send_password_reset
			expect(last_email.to).to include(@user.email)
		end
	end
end
