require 'rails_helper'

feature 'User can create order' do 

  background { visit new_order_path }

  scenario 'without input data' do 
    click_on 'Создать'
    
    expect(page).to have_content "Заказ успешно создан"
  end

  scenario 'with name' do
    fill_in "Ваше имя",	with: 'Сэм сэмов сэм'
    click_on 'Создать'
    
    expect(page).to have_content 'Заказ успешно создан'
  end

  scenario 'with name and banned ingredient' do
    Ingredient.create(name: 'Говядина')
    Ingredient.create(name: 'Яйца')
    Ingredient.create(name: 'Ваниль')
    
    visit new_order_path 

    fill_in "Ваше имя",	with: 'Сэм сэмов сэм'
    check 'Говядина'
    check 'Яйца'
    check 'Ваниль'
    click_on 'Создать'
    
    expect(page).to have_content 'Заказ успешно создан'
  end
end

feature 'User can ' do 

  background { 
    Dish.create(name: 'Краситель Риса', ingredients: ['Говядина', 'Яйца', 'Ваниль', 'Рис', 'Лапша' , 'Краситель'])
    Dish.create(name: 'Ванильная Лапша', ingredients: ['Говядина', 'Ваниль', 'Лапша'])
    Dish.create(name: 'Говяжья Ваниль', ingredients: ['Говядина', 'Яйца', 'Ваниль', 'Рис', 'Лапша' ])
    Dish.create(name: 'Яичный Рис', ingredients: ['Яйца', 'Рис', 'Лапша' , 'Краситель'])
    Order.create(client_name: 'Jora', banned_ingredients: ['Говядина', 'Рис'])
    Order.create(client_name: 'Shora', banned_ingredients: ['Краситель', 'Ваниль'])
    Order.create(client_name: 'Kora', banned_ingredients: ['Лапша', 'Яйца'])
    Order.create(client_name: 'Nona')

    visit orders_path 
  }

  scenario 'delete order' do 
    click_on 'Удалить', match: :first
    
    expect(page).to have_content "Заказ удален"
  end

  scenario 'send orders to kitchen' do 
    click_on 'Отправить на кухню'
    
    expect(page).to have_current_path('/orders/export.json')
  end
end