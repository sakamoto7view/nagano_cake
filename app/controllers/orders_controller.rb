class OrdersController < ApplicationController
  def new
		@customer = current_customer
	  #cartが空の場合、cart_items#indexに戻される
		if @customer.cart_items.blank?
 		   flash[:warning] = "カートが空です"
			 redirect_to cart_items_path
		else
			@order = Order.new(customer_id: @customer.id)
			@addresses = @customer.addresses
			@address = Address.new(customer_id: @customer.id)
		end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_select] == "ご自身の住所"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = "#{current_customer.last_name}" + "#{current_customer.first_name}"
    elsif params[:order][:address_select] == "登録済住所から選択"
          address = Address.find(params[:address_info][:address_id])
          @order.address = address.address
          @order.name = address.name
          @order.postal_code = address.postal_code
    elsif params[:order][:address_select] == "新しいお届け先"
          @order.postal_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
    end

    if params[:order][:payment_method] == "クレジットカード"
       @order.payment_method = "クレジットカード"
    elsif params[:order][:payment_method] == "銀行振込"
          @order.payment_method = "銀行振込"
    end
      @cart_items = current_customer.cart_items
      @sum = 0
  end

# 情報の保存
  def create
  	@order = Order.new(order_params)
  	@order.customer_id = current_customer.id
  	@customer = current_customer
  	@order.save

    current_customer.cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item.id
      order_detail.amount = cart_item.amount
      order_detail.pay = order_detail.amount * order_detail.item.price
      order_detail.save
      cart_item.destroy
    end

    redirect_to order_complete_path
  end

# 注文完了画面(カートを空にする)
  def complete

  end

  def index
		@customer = current_customer
		@orders = @customer.orders
	#他のuserのアクセス阻止
		#unless current_user.nil? || current_user.id == @user.id
    #flash[:warning] = "アクセス権がありません"
		  #redirect_to orders_path(id: current_user.id)
    #end
  end


  def show
  	@order = Order.find(params[:id])
  end

	private
#ストロングパラメーター
	def order_params
	 params.require(:order).permit(
	 	:customer_id, :payment_method, :address, :postal_code, :name
	 	)
	end

#退会済みユーザーへの対応
  def user_is_deleted
    if user_signed_in? && current_user.is_deleted?
       redirect_to root_path
    end
  end

#adminでなければuserの中で振り分ける
  def authenticate!
    if admin_signed_in?
    else
    	authenticate_user!
    end
  end

#ordersと直打ちした場合
  def params_check
  	if params[:id].nil?
  		redirect_to root_path
  	end
  end
end
