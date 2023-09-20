class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :client_name, defailt: 'Unknown'
      t.text :banned_ingredients, array: true, default: []
      t.text :food_set, array: true, default: []
      t.timestamps
    end
  end
end
