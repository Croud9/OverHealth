class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.string :name, null: false 
      t.text :ingredients, array: true, default: []
      t.timestamps
    end
  end
end