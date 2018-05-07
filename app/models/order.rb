class Order < ApplicationRecord

  belongs_to :pay_type
  validates :pay_type, :name, :address, :email, presence: true

  has_many :line_items, dependent: :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
