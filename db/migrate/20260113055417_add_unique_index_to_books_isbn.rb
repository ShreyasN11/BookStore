class AddUniqueIndexToBooksIsbn < ActiveRecord::Migration[8.1]
  def change
    add_index :books, :isbn, unique: true
  end
end
