class AddConstraintsToBooks < ActiveRecord::Migration[8.1]
  def change
    change_column_null :books, :title, false

    add_check_constraint :books,
                         "quantity >= 0",
                         name: "quantity_must_be_positive"
  end
end
