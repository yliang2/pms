require 'rails_helper'

RSpec.describe "PasswordResets", type: :feature do
  describe "Password_resets" do
    let(:user){ user = create(:user)}

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
        expect(page).to have_content("invaild email address.")
        expect(current_path).to be == new_password_resets_path        
    end

  end
end
