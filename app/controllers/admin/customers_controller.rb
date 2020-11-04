class Admin::CustomersController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to admin_customers_path(@customer)
  end
  
  def withdrawl
    @customer = Customer.find(current_customer.id)
    #現在ログインしているユーザーを@userに格納
    @customer.update(is_deleted: "true")
    #updateで登録情報をInvalidに変更
    reset_session
    #sessionIDのresetを行う
    redirect_to root_path
    #指定されたrootへのpath
  end

  private
  # ストロングパラメータ
  def customer_params
    params.require(:customer).permit(:id, :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :address, :postal_code, :telephone_number, :is_deleted)
  end

  
end
