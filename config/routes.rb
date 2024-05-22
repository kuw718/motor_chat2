Rails.application.routes.draw do
  
  get 'search', to: 'search#index'

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "homes#top"
  get "homes/about", to: "homes#about", as: :about
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
  member do
    post 'set_featured'
    post 'unset_featured'
  end
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
resources :customers, only: [:show, :edit, :update] do
  member do
    get :follows, :followers, :liked_posts
  end
  resource :relationships, only: [:create, :destroy]
end
  resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :posts, only: [:create], shallow: true
  end
  
  
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
}

  get '/admin', to: 'admin/homes#top'
  namespace :admin do
    resources :groups do
      resources :posts, only: [:destroy]
    end
    resources :post_images do
      resources :post_comments, only: [:edit, :update, :destroy]
    end
    resources :customers do
      member do
        delete :unsubscribe
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
