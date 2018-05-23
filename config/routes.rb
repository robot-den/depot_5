Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users

  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    root 'store#index', as: 'store_index', via: :all

    resources :orders do
      post :ship, on: :member
    end

    resources :line_items
    resources :carts
  end
end
