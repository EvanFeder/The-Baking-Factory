Rails.application.routes.draw do
  
  # Routes for main resources
  resources :addresses
  resources :customers
  resources :items
  resources :orders
  
  get 'item_prices/new', to: 'item_pricess#new', as: :new_item_price
  post 'item_prices', to: 'item_prices#create', as: :item_prices
  get 'order_items/new', to: 'order_items#new', as: :new_order_item
  post 'order_items', to: 'order_items#create', as: :order_items

  # Authentication
  resources :sessions
  resources :users
  get 'customers/new', to: 'customers#new', as: :signup
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  
  # Set the root url
  root :to => 'home#home'
  
end
