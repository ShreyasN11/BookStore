class User < ApplicationRecord
  enum :role, { customer: 0, admin: 1, stockmanager: 2, superadmin: 3 }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :orders
  has_one :cart, dependent: :destroy
  after_create :create_user_cart


def self.find_for_database_authentication(warden_conditions)
  conditions = warden_conditions.dup
  if (login = conditions.delete(:login))
    where(conditions.to_h).where([ "lower(username) = :value OR lower(email) = :value", { value: login.downcase } ]).first
  elsif conditions.has_key?(:username) || conditions.has_key?(:email)
    where(conditions.to_h).first
  end
end

  def create_user_cart
    create_cart
  end

  after_initialize do
    self.role ||= "customer" if new_record?
  end
end
