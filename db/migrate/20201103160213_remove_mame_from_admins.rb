class RemoveMameFromAdmins < ActiveRecord::Migration[5.2]
  def change
    remove_column :admins, :mame, :string
  end
end
