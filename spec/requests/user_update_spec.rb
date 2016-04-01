require 'rails_helper'

RSpec.describe "UserProfileUpdate", type: :feature do
  describe "User Profile Update" do
  	
    before(:each) do
      @admin = create(:user, :id => 1, :email => "admin@pms.com", :name => "admin")
      @user = create(:user, :id => 2,:admin => false)
      @user2 = create(:user, :id => 3, :name => @user.name + "2", :email => "2" + @user.email, :admin => false)
      @user3 = attributes_for(:user, :id => 4, :name => @user.name + "3", :email => "3" + @user.email, :admin => false)
    end 

    it "fail to update if user is not login" do
      visit logout_path
      visit edit_user_path(@user)
      expect(current_path).to be == login_path
    end    

    it "fail to update if is not user itself" do
      login(@user)
      visit edit_user_path(@user2)
      expect(page).to have_content("Only owner or admin permitted!")
      expect(current_path).to be == login_path
    end       

    it "fail to update a non-exist user if login user is admin" do
      login(@admin)          
      expect{visit edit_user_path(@user3)}.to raise_error(ActionView::Template::Error)      
    end   

    it "success to update if user is admin" do
      login(@admin)
      visit edit_user_path(@user)
      expect(current_path).to be == edit_user_path(@user)
      expect(page).to have_selector("input[value='#{@user.name}']")
      expect(page).to have_selector("input[value='#{@user.email}']")      
      edit_registration_input(@user)
      click_button "Update User"      
      expect(page).to have_content("Update successful!")      
    end       
     
  end
end
