class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end
  
  def new
    @order = Order.new
    @ingredients = Ingredient.all
  end

  def create
    food_set = Order.food_set_generate(params)
    @order = Order.new(client_name: params['client_name'], banned_ingredients: params['banned_ingredients'], food_set: food_set)
    if @order.save
      redirect_to new_order_path, notice: 'Заказ успешно создан'
    else
      flash.now[:success] = "Заказ не создан"
      render turbo_stream: turbo_stream.replace("flash_notice", partial: "layouts/flash", locals: { flash: flash })
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    redirect_to orders_path, notice: 'Заказ удален'
  end

  def export
    respond_to do |format|
      format.json do
        output = Order.to_json()
        send_data output,
          type: :json,
          disposition: 'inline'
      end
    end
  end
end
