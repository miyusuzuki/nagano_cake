class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :ordered_products, dependent: :destroy
  belongs_to :genre
  has_one_attached :image
  def add_tax_price
        (self.price * 1.08).round
  end
end
