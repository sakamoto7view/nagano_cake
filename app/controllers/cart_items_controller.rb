class CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum(:price)
  end



  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) #https://teratail.com/questions/280481
      if @cart_item.present?
         @cart_item.amount += params[:cart_item][:amount].to_i
         @cart_item.save
         redirect_to cart_items_path
      elsif @cart_item = CartItem.new(item_params) #https://qiita.com/yowashi/items/f124c82f02a19245965a
          @cart_item.customer_id = current_customer.id
          @cart_item.save
          redirect_to cart_items_path
      end
    @cart_item.price = @cart_item.item.price * @cart_item.amount
  end


#再計算
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:cart_item][:amount].to_i)
    redirect_to cart_items_path
  end



  #ある商品の入ったカートを空にする
  def destroy
    @cart_item = CartItem.find(params[:id])
  	@cart_item.destroy
    redirect_to cart_items_path
  end

  #カートを空にする
  def destroy_all
  	@cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end



  private
    def item_params
      params.require(:cart_item).permit(:customer_id, :item_id, :amount, :price)
    end


    #退会済みユーザーへの対応
    def user_is_deleted
      if user_signed_in? && current_user.is_deleted?
         redirect_to root_path
      end
    end

end
