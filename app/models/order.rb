class Order < ApplicationRecord

  def self.food_set_generate params
    food_set = []
    if params['banned_ingredients']
      Dish.all.each do |dish|
        food_set << dish.name if (params['banned_ingredients'] & dish.ingredients).empty? 
      end
    else
      Dish.all.each do |dish|
        food_set << dish.name 
      end
    end
    food_set
  end

  def self.to_json
    output = []
    dishes = Hash.new(0) 

    Order.all.each do |order|
      order.food_set.each { | v | dishes.store(v, dishes[v]+1) }
    end 

    dishes.sort{|a, b| b.last <=> a.last }.each do |name, count|
      output << { 
        name: name, 
        count: count 
      }
    end

    output.to_json

  end
end
