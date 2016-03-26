require 'rails_helper'

RSpec.describe "PasswordResets", type: :feature do
  let(:user){ user = create(:user, :password_reset_token => "test_pws_reset_token")}  
  
  describe "Password_resets" do

    it "send reset email" do
        visit new_password_resets_path        
    	fill_in "Email", :with => user.email
    	click_button "Rest Password"
    	expect(page).to have_content("Email sent")
    	expect(last_email.to).to include(user.email)
    	expect(current_path).to be == root_path
    end

    it "does not email invaild email" do
        visit new_password_resets_path
        fill_in "Email", :with => "fake_" + user.email
        click_button "Rest Password"
        expect(page).to have_content("Invaild email address.")
        expect(current_path).to be == new_password_resets_path        
    end
  end

  describe "#Password update" do
    it "render password update view" do
        user.send_password_reset
        visit edit_password_resets_path(user.password_reset_token)
        expect(current_path).to be == edit_password_resets_path(user.password_reset_token)        
    end
  end
end
