require 'rails_helper'

RSpec.describe "Authentications", type: :feature do
  describe "GET /authentications" do
    it "has username and password field" do
      visit login_path
      expect(page).to have_field("name")
      expect(page).to have_field("password")
    end

    it "Fails to login with wrong user name" do
      user = create(:user)
      visit login_path
      fill_in "Name", :with => "fake_" + user.name
      fill_in "Password", :with => user.password
      click_button "Login"
      expect(page).to have_content("Wrong username or password")
    end

    it "Fails to login with wrong user password" do
      user = create(:user)
      visit login_path
      fill_in "Name", :with => user.name
      fill_in "Password", :with => "fake_" + user.password
      click_button "Login"
      expect(page).to have_content("Wrong username or password")
    end

    it "Successfully login with correct user name and password" do
      user = create(:user)
      visit login_path
      fill_in "Name", :with => user.name
      fill_in "Password", :with => user.password
      click_button "Login"
      expect(page).to have_content("You are login as:#{user.name}")
    end    

    it "redirect to authentication when a user is not authenticated" do
      visit root_path
      expect(current_path).to be == login_path
    end  

  end
end
