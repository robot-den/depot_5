class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id) || line_items.build(product_id: product.id)
    current_item.quantity += 1 if current_item.persisted?
    current_item
  end
end
