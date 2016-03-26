require 'rails_helper'

RSpec.describe "UserRegistrations", type: :feature do
  describe "User registrations" do
  	
  	let(:user) do
  		user = build(:user)
  	end

    it "register user as admin" do
      new_registration_input(user)
      click_button "Create User"
      expect(current_path).to be == root_path
    end    

    it "fails to register user when user email exist" do
	    new_registration_input(user)
      click_button "Create User"
      user.name = "diff_" + user.name
	    new_registration_input(user)
      click_button "Create User"
      expect(page).to have_content("Email has already been taken")
      expect(page).to_not have_content("Name has already been taken")
    end

    it "fails to register user when user name exist" do
	    new_registration_input(user)
      click_button "Create User"
      user.email = "diff_" + user.email
	    new_registration_input(user)
      click_button "Create User"
      expect(page).to have_content("Name has already been taken")
      expect(page).to_not have_content("Email has already been taken")
    end    
  end
end
