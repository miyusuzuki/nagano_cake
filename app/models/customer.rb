class Customer < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :order_informations, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def name
    last_name + first_name
  end
end
