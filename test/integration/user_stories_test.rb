require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  fixtures :orders
  fixtures :pay_types
  fixtures :users
  include ActiveJob::TestHelper

  # A user goes to the index page. They select a product, adding it to their
  # cart, and check out, filling in their details on the checkout form. When
  # they submit, an order is created containing their information, along with a
  # single line item corresponding to the product they added to their cart.
  test "buying a product" do
    # remember initial state
    start_order_count = Order.count
    ruby_book = products(:ruby)
    # user goes to index page
    get '/'
    assert_response :success
    assert_select 'h1', 'Your Pragmatic Catalog'
    # user click add product button that uses AJAX
    post '/line_items', params: { product_id: ruby_book.id }, xhr: true
    assert_response :success
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.count
    assert_equal ruby_book, cart.line_items.first.product
    # user go to 'check out' page
    get '/orders/new'
    assert_response :success
    assert_select 'legend', 'Please Enter Your Details'
    # user fills form and send create order request
    perform_enqueued_jobs do
      post '/orders', params: {
        order: {
          name: 'Denis',
          address: 'Address',
          email: 'email@test.com',
          pay_type_id: pay_types(:one).id
        }
      }
      follow_redirect!
      assert_response :success
      assert_select 'h1', 'Your Pragmatic Catalog'
      cart = Cart.find(session[:cart_id])
      assert_equal 0, cart.line_items.count
      assert_equal start_order_count + 1, Order.count
      order = Order.last
      assert_equal 'Denis', order.name
      assert_equal 'Address', order.address
      assert_equal 'email@test.com', order.email
      assert_equal pay_types(:one), order.pay_type
      assert_equal 1, order.line_items.count
      assert_equal ruby_book, order.line_items.first.product

      mail = ActionMailer::Base.deliveries.last
      assert_equal ["email@test.com"], mail.to
      assert_equal 'Denis Nazmutdinov <depot_5@example.com>', mail[:from].value
      assert_equal "Pragmatic store order confirmation", mail.subject
    end
  end

  # An seller goes to the orders page. They see orders that customer made.
  # They click ship.
  test "ship order" do
    order = orders(:one)
    # user goes to orders page
    get '/orders'
    assert_response :success
    assert_select 'h1', 'Orders'
    assert_select ".order_row_#{order.id}", 1
    # user click ship order
    perform_enqueued_jobs do
      post "/orders/#{order.id}/ship"
      follow_redirect!
      assert_response :success
      assert_select 'h1', 'Orders'
      assert_select ".order_row_#{order.id}", 1
      assert_select '#notice', "Order ##{order.id} was successfully shipped!"
      assert_select ".order_row_#{order.id} td", 'Shipped'

      mail = ActionMailer::Base.deliveries.last
      assert_equal [order.email], mail.to
      assert_equal 'Denis Nazmutdinov <depot_5@example.com>', mail[:from].value
      assert_equal "Pragmatic store order shipped", mail.subject
    end
  end

  # User try to access invalid cart. They go to /carts/x page, where x is not user's cart id
  test "invalid cart access" do
    perform_enqueued_jobs do
      get '/carts/x'
      follow_redirect!
      assert_response :success
      assert_select 'h1', 'Your Pragmatic Catalog'
      assert_select '#notice', "Invalid cart"

      mail = ActionMailer::Base.deliveries.last
      assert_equal ['admin@test.com'], mail.to
      assert_equal 'from@example.com', mail[:from].value
      assert_equal "Attempt to access invalid cart", mail.subject
    end
  end
end
