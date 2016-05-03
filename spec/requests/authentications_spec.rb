require 'rails_helper'

RSpec.describe "Authentications", type: :feature do
  describe "Authentications" do
    before(:each) do
       @user = create(:user, :id => 1, :password_reset_token => "test_pws_reset_token", :password_reset_sent_at => DateTime.now)
       @admin = create(:user, :id => 2, :email => "admin@pms.com", :name => "admin")
    end 

    it "Fails to login with wrong user name" do
      @user.name = "fake_" + @user.name
      @user.password = @user.password
      login(@user)
      expect(page).to have_content("Wrong username or password")
    end

    it "Fails to login with wrong user password" do
      @user.name = @user.name
      @user.password = "fake_" + @user.password
      login(@user)
      expect(page).to have_content("Wrong username or password")
    end

    it "Successfully login with correct user name and password" do
      login(@user)
      expect(page).to have_content("You are login as:#{@user.name}")
      expect(page).to have_content("logout")
      expect(current_path).to be == user_path(@user)
    end    

    it "Logout current user" do
      visit logout_path
      expect(page).to have_content("logged out!")
      expect(current_path).to be == login_path
      login(@user)
      visit logout_path
      expect(page).to have_content("#{@user.name} logged out!")
      expect(current_path).to be == login_path
    end 

    it "Logout current user before login" do
      login(@user)
      expect(page).to have_content("You are login as:#{@user.name}")
      visit login_path
      @new_login_user = create(:user, :id => 3, :name => "second_" + @user.name, :email => "second_" + @user.email)
      login(@new_login_user)
      expect(page).to have_content("#{@user.name} logged out!")
      expect(page).to have_content("You are login as:#{@new_login_user.name}")
      expect(current_path).to be == user_path(@new_login_user.id)
    end       

    it "redirect to authentication when a user is not authenticated" do
      visit root_path
      expect(current_path).to be == login_path
    end  

    it "redirect to password reset" do
      login(@admin)
      visit login_path
      page.find("#password_reset").click
      expect(current_path).to be == new_password_reset_path
    end

  end
end
