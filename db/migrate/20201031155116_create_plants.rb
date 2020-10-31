class CreatePlants < ActiveRecord::Migration[6.0]
  def change
    create_table :plants do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :price

      t.timestamps
    end
  end
end
