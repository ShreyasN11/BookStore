class AddQuantityToBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :books, :quantity, :integer, default: 1, null: false
  end
end
