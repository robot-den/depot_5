class AddPriceToLineItems < ActiveRecord::Migration[5.1]
  def up
    add_column :line_items, :price, :float, precision: 8, scale: 2

    LineItem.all.each do |li|
      li.update(price: li.product.price)
    end
  end

  def down
    remove_column :line_items, :price
  end
end
