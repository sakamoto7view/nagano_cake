class ChangeStatusOfOrderDetails < ActiveRecord::Migration[5.2]
  def change
    change_column_default :order_details, :making_status, from: 0, to: 1
  end
end
