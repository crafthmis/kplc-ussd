# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if ENV['current_organization'] == "KPLC"
	unless Rails.env.production?
		puts owner = User.find_or_create_by(email: 'dunake@gmail.com')
		puts owner.password = "ingenious"
		puts owner.save
	else
		puts owner = User.find_or_create_by(email: 'dakello@kplc.co.ke')
		puts owner.password = "ingenious"
		puts owner.save
	end
end

interfaces = {  "Cloud Contact Center" => "Automate and configure your contact center",
				"Projects" => "Automate your marketing and sales workflows",
				"Social Media" => "Configure your social media accounts",
				"Voice Manager" => "Configure and automate voice workflows",
				"Application Monitor" => "Configure and automate voice workflows",
				"SMS Manager" => "Configure and create your SMS campaigns",
				"USSD Manager" => "Configure and create your USSD workflows",
				"Email Manager" => "Configure and create your email campaigns",
			    "Token Tracker" => "Kplc token tracker interface",
			    "Business Intelligence" => "Kenya power business inteligence interface",
			    "Admin" => "General admin interface" }

interfaces.each do |key,value|
  interface =  Interface.find_or_create_by(name: key)
  interface.description = value
  puts interface.save

end


puts organization = Organization.create(name: "KPLC",owner: owner)
