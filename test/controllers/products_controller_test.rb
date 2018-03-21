require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  fixtures :products

  setup do
    @product = products(:one)
    @update = {
      title: 'Lorem Ipsum',
      description: 'Description',
      image_url: 'lorem.jpg',
      price: 19.99
    }
  end

  test "should get index" do
    get products_url
    assert_response :success
    assert_select '.list_description', 3
    assert_select 'dt', 'Programming Ruby 1.9'
    assert_select '.list_actions a', "Show"
    assert_select '.list_actions a', "Edit"
    assert_select '.list_actions a', "Destroy"
    assert_select 'a', "New product"
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: @update }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: @update }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
