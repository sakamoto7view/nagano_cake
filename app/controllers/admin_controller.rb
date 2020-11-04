class AdminController < ApplicationController
  
  def top
    @orders = Order.created_today
  	@count = @orders.count
  end
  
end
