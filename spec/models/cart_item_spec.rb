require "rails_helper"

RSpec.describe CartItem, type: :model do
  it "belongs to cart" do
    assoc = described_class.reflect_on_association(:cart)
    expect(assoc.macro).to eq :belongs_to
  end

  it "belongs to book" do
    assoc = described_class.reflect_on_association(:book)
    expect(assoc.macro).to eq :belongs_to
  end

  it "is invalid with zero quantity" do
    item = CartItem.new(quantity: 0)
    expect(item).not_to be_valid
  end
end
