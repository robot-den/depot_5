require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  fixtures :orders
  fixtures :line_items

  test "received" do
    order = orders(:one)
    line_item = line_items(:one)
    order.line_items << line_item
    mail = OrderMailer.received(order)
    assert_equal 'Pragmatic store order confirmation', mail.subject
    assert_equal [order.email], mail.to
    assert_equal ['depot_5@example.com'], mail.from
    assert_match /1 x #{line_item.product.title}/, mail.body.encoded
  end

  test "shipped" do
    order = orders(:one)
    line_item = line_items(:one)
    order.line_items << line_item
    mail = OrderMailer.shipped(orders(:one))
    assert_equal 'Pragmatic store order shipped', mail.subject
    assert_equal [orders(:one).email], mail.to
    assert_equal ['depot_5@example.com'], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>#{line_item.product.title}<\/td>/, mail.body.encoded
  end

end
