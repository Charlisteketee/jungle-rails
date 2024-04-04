class Admin::DashboardController < ApplicationController
  def show #the controller fetches the data and passes it to view template
    @product_count = Product.count
    @category_count = Category.count
  end
end
