class CleanupBookAuthors < ActiveRecord::Migration[8.1]
  def change
    remove_column :books, :author, :string
    change_column_null :books, :author_id, false
  end
end
