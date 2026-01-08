require "rails_helper"

RSpec.describe OrderItem, type: :model do
  it "belongs to order" do
    assoc = described_class.reflect_on_association(:order)
    expect(assoc.macro).to eq :belongs_to
  end

  it "belongs to book" do
    assoc = described_class.reflect_on_association(:book)
    expect(assoc.macro).to eq :belongs_to
  end

  it "is invalid with quantity <= 0" do
    item = OrderItem.new(quantity: 0)
    expect(item).not_to be_valid
  end
end
