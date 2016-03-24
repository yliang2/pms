FactoryGirl.define do
	factory :user do
		name "pms"
		email "pms@example.com"
		password "abc123"
		password_confirmation "abc123"
		admin true
	end
end