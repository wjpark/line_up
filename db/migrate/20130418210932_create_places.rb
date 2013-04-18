class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :url
      t.integer :checkins
      t.integer :herenow
      t.string :icon

      t.timestamps
    end
  end
end
