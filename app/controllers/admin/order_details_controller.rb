class Admin::OrderDetailsController < ApplicationController

  def update
#orderのdeposit_statusの更新
    #binding.pry
  	@order = Order.find(params[:order_id])
  	@order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
  	#@order_detail = OrderDeatil.find(params[:id])
    #@order = Order.find(order_detail_id: @order_detail.id)

    #@order_detail = OrderDeatil.find(id: params[:id])



	if ['製作中'].include?(@order_detail.making_status)
	   @order.update(status: 2)
	end
	   
	if @order.order_details.where.not(making_status: "製作完了").empty?
	   @order.update(status: 3)
	end
	
	     #@order.order_details.each do |order_detail|
  	   #order_detail.making_status = "製作待ち"
  	   #if order_detail != "製作完了"
  	   #break
  	   #end 
	
	#if @order.status == "入金確認"
  	   
  	   #order_detail.update(making_status: 1)
  #end
  	redirect_to '/admin/orders'
  end

  private
  def order_detail_params
  	params.require(:order_detail).permit(:id, :making_status)
  end


end