require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products

  test "add products" do
    cart = Cart.new
    LineItem.delete_all
    cart.add_product(products(:one)).save!
    cart.add_product(products(:ruby)).save!
    cart.add_product(products(:ruby)).save!
    assert_equal 2, cart.line_items.count
    total_price = products(:one).price + 2 * products(:ruby).price
    assert_equal total_price, cart.total_price
  end
end
