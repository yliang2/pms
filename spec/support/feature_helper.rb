module FeatureHelper
	def new_registration_input(user)
      visit new_users_path
      fill_in "user[name]", :with => user.name
      fill_in "user[email]", :with => user.email
      fill_in "user[password]", :with => user.password
      fill_in "user[password_confirmation]", :with => user.password_confirmation
      check "user[admin]", user.admin ?  :checked : :unchecked
	end
end