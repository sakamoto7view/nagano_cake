class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def index
  	   @orders = Order.all
  end

  def show
  	@order = Order.find(params[:id])
  	#@order_details = @order.order_details
  end

  def update
#orderのdeposit_statusの更新
  	@order = Order.find(params[:id])
    @order.update(order_params)
    flash[:success] = "更新に成功しました"
  	if @order.status == "入金確認"
  	   @order.order_details.each do |order_detail|
  	   #order_detail.making_status = "製作待ち"
  	   order_detail.update(making_status: 1)

  	   end
  	end
  	redirect_to admin_orders_path
  end

  private
  def order_params
  	params.require(:order).permit(:status, order_details_attributes:[:id, :making_status])
  end

end
