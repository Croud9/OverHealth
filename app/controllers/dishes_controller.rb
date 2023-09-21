class DishesController < ApplicationController
  def index
    @dishes = Dish.all
    @ingredients = Ingredient.all
  end

  def new
    @dish = Dish.new
    @ingredients = Ingredient.all
  end
  
  def create 
    dish = Dish.new(name: params[:name], ingredients: params[:ingredients])
    if params[:ingredients] && dish.save
      redirect_to dishes_path, notice: 'Блюдо успешно создано'
    else
      flash.now[:success] = "Укажите состав блюда"
      render turbo_stream: turbo_stream.replace("flash_notice", partial: "layouts/flash", locals: { flash: flash })
    end
  end

  def destroy
    dish = Dish.find(params[:id])
    dish.destroy
    redirect_to dishes_path, notice: 'Блюдо удалено'
  end

  def import 
    data = DishesHelper.import_yml(params[:file])

    if data != 'file_error'
      project = data[:project]
      if Ingredient.create!(data[:ingredients]) && Dish.create!(data[:dishes])
        redirect_to dishes_path, notice: "Блюда и ингредиенты добавлены"
      else
        flash.now[:success] = "Блюда и ингредиенты не добавлены"
        render turbo_stream: turbo_stream.replace("flash_notice", partial: "layouts/flash", locals: { flash: flash })
      end
    else
      flash.now[:error] = "C файлом что-то не так"
      render turbo_stream: turbo_stream.replace("flash_notice", partial: "layouts/flash", locals: { flash: flash })
    end
  end
end
