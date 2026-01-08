require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    user = User.new(
      email: "user@example.com",
      password: "password123"
    )

    expect(user).to be_valid
  end

  it "has many orders" do
    assoc = described_class.reflect_on_association(:orders)
    expect(assoc.macro).to eq :has_many
  end

  it "has one cart" do
    assoc = described_class.reflect_on_association(:cart)
    expect(assoc.macro).to eq :has_one
  end
end
