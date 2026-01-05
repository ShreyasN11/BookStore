puts "🌱 Seeding order items..."

OrderItem.destroy_all

order_items = [
  # Order 1 (User 1)
  {
    order_id: 1,
    book_id: 5,
    quantity: 1,
    price: 499.00
  },
  {
    order_id: 1,
    book_id: 6,
    quantity: 2,
    price: 200.00
  },

  # Order 2 (User 1)
  {
    order_id: 2,
    book_id: 8,
    quantity: 1,
    price: 899.50
  },

  # Order 3 (User 2)
  {
    order_id: 3,
    book_id: 10,
    quantity: 1,
    price: 299.99
  },

  # Order 4 (User 2)
  {
    order_id: 4,
    book_id: 7,
    quantity: 2,
    price: 649.50
  }
]

OrderItem.create!(order_items)

puts "✅ Order items seeded successfully!"
