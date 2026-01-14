class AddAdminOverriddenToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :admin_overridden, :boolean, default: false
  end
end
