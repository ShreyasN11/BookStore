
admin = User.find_or_create_by!(email: "trial@ebookstore.com") do |user|
  user.name = "trial user"
  user.username = "trialuser"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = :customer
end

puts "Successfully created new user"
