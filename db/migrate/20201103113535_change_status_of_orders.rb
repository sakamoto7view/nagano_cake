class ChangeStatusOfOrders < ActiveRecord::Migration[5.2]
  def change
    change_column_default :orders, :status, from: 1, to: 0
  end
end
