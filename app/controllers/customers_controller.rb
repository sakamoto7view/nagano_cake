class CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to '/customers/my_page'
  end

  def unsubscribe
    @customer = current_customer
    #ユーザーの情報を見つける
  end

  def withdrawl
    @customer = Customer.find(current_customer.id)
    #現在ログインしているユーザーを@userに格納
    @customer.update(is_deleted: "Invalid")
    #updateで登録情報をInvalidに変更
    reset_session
    #sessionIDのresetを行う
    redirect_to root_path
    #指定されたrootへのpath
  end

  #@customer = Customer.find(params[:id])

  	#if  @customer.is_deleted?
  		  #@customer.is_deleted = false
  	#else
  		  #@customer.is_deleted = true
  	#end
        #@customer.save
        #redirect_to edit_admin_customer_path(@customer)
  #end


  private
  # ストロングパラメータ
  def customer_params
    params.require(:customer).permit(:id, :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :address, :postal_code, :telephone_number, :is_deleted)
  end
end
