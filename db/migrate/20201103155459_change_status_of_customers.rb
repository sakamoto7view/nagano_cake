class ChangeStatusOfCustomers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :customers, :is_deleted, from: false, to: true
  end
end
