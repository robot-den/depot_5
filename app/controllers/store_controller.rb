class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @root_visit_count = session[:counter].to_i
    session[:counter] = @root_visit_count + 1
  end
end
