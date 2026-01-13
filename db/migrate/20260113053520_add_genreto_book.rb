class AddGenretoBook < ActiveRecord::Migration[8.1]
  def change
    add_column :books, :genre, :string, default: "General"
  end
end
