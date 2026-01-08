require "rails_helper"

RSpec.describe "CSV Export", type: :request do
  let!(:user) do
    User.create!(
      email: "csv@test.com",
      password: "password123",
      role: :customer
    )
  end
  let!(:book) do
    Book.create!(title: "Test Book", author: "Author", price: 100)
  end

  let!(:order) do
    Order.create!(user: user, total_price: 100)
  end

  let!(:order_item) do
    OrderItem.create!(
      order: order,
      book: book,
      quantity: 1,
      price: 100
    )
  end

  before do
    post user_session_path, params: {
      user: { email: user.email, password: "password123" }
    }
  end

  it "downloads order CSV" do
    get user_path(user, format: :csv)
    expect(response.headers["Content-Type"]).to include("text/csv")
    expect(response.body).to include("Book")
    expect(response.body).to include("Test Book")
  end
end
