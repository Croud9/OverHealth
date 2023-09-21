module OrdersHelper
  def self.food_set_generate params
    food_set = []
    Dish.all.each do |dish|
      food_set << dish.name if !params['banned_ingredients'] || (params['banned_ingredients'] & dish.ingredients).empty?
    end
    food_set
  end

end
