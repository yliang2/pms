require 'rails_helper'

RSpec.describe "PasswordResets", type: :feature do
  before(:each){ @user = create(:user,:password_reset_token => "test_pws_reset_token", :password_reset_sent_at => DateTime.now)}  
  
  describe "Password_resets" do

    it "send reset email" do
        visit new_password_reset_path        
    	fill_in "Email", :with => @user.email
    	click_button "Rest Password"
    	expect(page).to have_content("Email sent")
    	expect(last_email.to).to include(@user.email)
    	expect(current_path).to be == root_path
    end

    it "does not email invaild email" do
        visit new_password_reset_path
        fill_in "Email", :with => "fake_" + @user.email
        click_button "Rest Password"
        expect(page).to have_content("Invaild email address.")
        expect(current_path).to be == new_password_reset_path        
    end
  end

  describe "#Password reset edit" do
    it "fail to edit password edit when token is invaild" do
        @user.send_password_reset
        expect{visit edit_password_reset_path(@user.password_reset_token + "_fake_token")}.to raise_error(ActionController::RoutingError)             
    end

    it "success to edit password when token is valid" do
        @user.send_password_reset
        visit edit_password_reset_path(@user.password_reset_token)
        expect(current_path).to be == edit_password_reset_path(@user.password_reset_token)        
        expect(page).to have_content("Reset Password")    
    end
  end

  describe "#Password reset update" do
    it "fail to update password  when passwords doesn't match" do
        @user.send_password_reset
        visit edit_password_reset_path(@user.password_reset_token)
        fill_in "user[password]", :with => @user.password
        fill_in "user[password_confirmation]", :with =>""
        click_button "Update Password"    
        expect(current_path).to be == edit_password_reset_path(@user.password_reset_token)
        expect(page).to have_content("Password update fail!")            
    end

    it "fail to update password when time is expired" do
        @user.send_password_reset
        @user.password_reset_sent_at = 3.hours.ago
        @user.save
        visit edit_password_reset_path(@user.password_reset_token)
        fill_in "user[password]", :with => @user.password
        fill_in "user[password_confirmation]", :with => @user.password_confirmation
        click_button "Update Password"    
        expect(current_path).to be == new_password_reset_path
        expect(page).to have_content("Password update time has expired!")            
    end

    it "success to update  password when time is not expired" do
        @user.send_password_reset
        @user.password_reset_sent_at = 1.hours.ago
        @user.save
        visit edit_password_reset_path(@user.password_reset_token)
        fill_in "user[password]", :with => @user.password
        fill_in "user[password_confirmation]", :with => @user.password_confirmation
        click_button "Update Password"    
        expect(current_path).to be == root_path
        expect(page).to have_content("Password update successful!")    
    end
  end

end
