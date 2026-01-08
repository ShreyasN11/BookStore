require "rails_helper"

RSpec.describe Book, type: :model do
  it "is valid with valid attributes" do
    book = Book.new(
      title: "Atomic Habits",
      author: "James Clear",
      price: 499,
      quantity: 1
    )

    expect(book).to be_valid
  end

  it "is invalid without a title" do
    book = Book.new(title: nil)
    expect(book).not_to be_valid
  end

  it "does not allow negative quantity" do
    book = Book.new(quantity: -1)
    expect(book).not_to be_valid
  end
end
