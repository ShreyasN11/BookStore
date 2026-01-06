class User < ApplicationRecord
  enum :role, { customer: 0, admin: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :orders
  has_one :cart, dependent: :destroy
  after_create :create_user_cart

  def create_user_cart
    create_cart
  end

  after_initialize do
    self.role ||= "customer" if new_record?
  end
end
