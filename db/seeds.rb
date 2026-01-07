puts "Creating Admin User..."

admin = User.find_or_create_by!(email: "superadmin@ebookstore.com") do |user|
  user.name = "Super Admin"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = :superadmin
end

puts "Successfully created superadmin:"
