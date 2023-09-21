require 'rails_helper'

feature 'User can ' do 

  scenario 'create new dish' do 
    visit dishes_path 

    click_on 'Новое блюдо'
    expect(page).to have_current_path('/dishes/new')
  end

  scenario 'delete dish' do 
    Dish.create(name: 'Краситель Риса', ingredients: ['Говядина', 'Яйца', 'Ваниль', 'Рис', 'Лапша' , 'Краситель'])
    Dish.create(name: 'Ванильная Лапша', ingredients: ['Говядина', 'Ваниль', 'Лапша'])
    Dish.create(name: 'Говяжья Ваниль', ingredients: ['Говядина', 'Яйца', 'Ваниль', 'Рис', 'Лапша' ])

    visit dishes_path 

    click_on 'Удалить', match: :first
    expect(page).to have_content 'Блюдо удалено'
  end

  scenario 'create dish with name and ingredients' do
    Ingredient.create(name: 'Мёд')
    Ingredient.create(name: 'Яйца')
    Ingredient.create(name: 'Мука')
    
    visit new_dish_path 

    fill_in "name",	with: 'Чак-чак'
    check 'Мёд'
    check 'Яйца'
    check 'Мука'
    click_on 'Создать'
    
    expect(page).to have_content 'Блюдо успешно создано'
  end

  scenario 'load yml file in database' do
    visit dishes_path 
    
    attach_file('file', Rails.root + "spec/fixtures/menu.yml") 
    click_on 'Импортировать YML'
    
    expect(page).to have_content 'Блюда и ингредиенты добавлены'
  end


end