class Order < ApplicationRecord
  
  def self.to_json
    output = []
    dishes = Hash.new(0) 

    Order.all.each { |order| order.food_set.each { | v | dishes.store(v, dishes[v] + 1) } }

    dishes.sort{ |a, b| b.last <=> a.last }.each do |name, count|
      output << { 
        name: name, 
        count: count 
      }
    end
    output.to_json
  end
end
