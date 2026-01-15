puts "Seeding users..."

User.find_or_create_by!(email: "admin@bookstore.com") do |user|
  user.password = "Admin@123"
  user.password_confirmation = "Admin@123"
  user.name = "Admin User"
  user.username = "admin"
  user.phone = "9999999999"
  user.role = :admin
end

User.find_or_create_by!(email: "superadmin@bookstore.com") do |user|
  user.password = "SuperAdmin@123"
  user.password_confirmation = "SuperAdmin@123"
  user.name = "Super Admin"
  user.username = "superadmin"
  user.phone = "8888888888"
  user.role = :super_admin
end

User.find_or_create_by!(email: "stockmanager@bookstore.com") do |user|
  user.password = "Stock@123"
  user.password_confirmation = "Stock@123"
  user.name = "Stock Manager"
  user.username = "stockmanager"
  user.phone = "7777777777"
  user.role = :stockmanager
end

puts "✅ SuperAdmin, Admin and Stock Manager added successfully"
