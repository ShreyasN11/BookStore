puts "Creating Admin User..."

admin = User.find_or_create_by!(email: "admin@ebookstore.com") do |user|
  user.name = "Site Administrator"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = :admin
end

puts "Successfully created admin:"
