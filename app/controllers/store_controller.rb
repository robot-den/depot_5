class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart

  def index
    @products = Product.order(:title)
    @root_visit_count = session[:counter].to_i
    session[:counter] = @root_visit_count + 1
  end
end
