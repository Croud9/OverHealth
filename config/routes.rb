Rails.application.routes.draw do
  root "orders#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :orders do
    collection do
      get :export                                                             
    end
  end
  resources :dishes do
    collection do
      post :import                                                          
    end
  end
end
