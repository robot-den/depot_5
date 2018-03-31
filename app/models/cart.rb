class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    item = line_items.find_by(product_id: product.id) || line_items.build(product_id: product.id, price: product.price)
    item.quantity += 1 if item.persisted?
    item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
