require 'rails_helper'

RSpec.describe "UserRegistrations", type: :feature do
  describe "GET /user_registrations" do
    it "register user as admin" do
      user = build(:user)
      visit new_users_path
      fill_in "user[name]", :with => user.name
      fill_in "user[email]", :with => user.email
      fill_in "user[password]", :with => user.password
      fill_in "user[password_confirmation]", :with => user.password_confirmation
      check "user[admin]", user.admin ?  :checked : :unchecked
      click_button "Create User"
      expect(current_path).to be == root_path
    end    

    it "fails to register user when user email exist" do
      user = build(:user)
      visit new_users_path
      fill_in "user[name]", :with => user.name
      fill_in "user[email]", :with => user.email
      fill_in "user[password]", :with => user.password
      fill_in "user[password_confirmation]", :with => user.password_confirmation
      check "user[admin]", user.admin ?  :checked : :unchecked
      click_button "Create User"
      fill_in "user[name]", :with => "diff_" + user.name
      fill_in "user[email]", :with => user.email
      fill_in "user[password]", :with => user.password
      fill_in "user[password_confirmation]", :with => user.password_confirmation
      check "user[admin]", user.admin ?  :checked : :unchecked
      click_button "Create User"
      expect(page).to have_content("Email has already been taken")
    end

    it "fails to register user when user name exist" do
      user = build(:user)
      visit new_users_path
      fill_in "user[name]", :with => user.name
      fill_in "user[email]", :with => user.email
      fill_in "user[password]", :with => user.password
      fill_in "user[password_confirmation]", :with => user.password_confirmation
      check "user[admin]", user.admin ?  :checked : :unchecked
      click_button "Create User"
      fill_in "user[name]", :with =>  user.name
      fill_in "user[email]", :with => "diff_" + user.email
      fill_in "user[password]", :with => user.password
      fill_in "user[password_confirmation]", :with => user.password_confirmation
      check "user[admin]", user.admin ?  :checked : :unchecked
      click_button "Create User"
      expect(page).to have_content("Name has already been taken")
    end    
  end
end
