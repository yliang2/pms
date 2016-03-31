module FeatureHelper
	def new_registration_input(user)
            visit new_user_path
            fill_in "user[name]", :with => user.name
            fill_in "user[email]", :with => user.email
            fill_in "user[password]", :with => user.password
            fill_in "user[password_confirmation]", :with => user.password_confirmation
            check "user[admin]", user.admin ?  :checked : :unchecked
	end

	def login(user)
      	visit login_path
            fill_in "name", :with => user.name
            fill_in "password", :with => user.password
            click_button "Login"
	end
end