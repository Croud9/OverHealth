module DishesHelper
  require 'yaml'
  
  def self.import_yml file
    
    begin
      dishes = []
      ingredients = []
      data_file = YAML::load File.open(file.path)
      
      data_file['dishes'].each do |dish|
        dishes << {
          name: dish['name'],
          ingredients: dish['ingredients'],
        }
      end

      data_file['ingredients'].each do |name|
        ingredients << {
          name: name,
        }
      end

      { dishes: dishes, ingredients: ingredients }
    rescue
      'file_error'
    end
  end
end
