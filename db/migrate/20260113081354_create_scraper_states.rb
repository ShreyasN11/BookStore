class CreateScraperStates < ActiveRecord::Migration[8.1]
  def change
    create_table :scraper_states do |t|
      t.string :name
      t.integer :last_page

      t.timestamps
    end
  end
end
