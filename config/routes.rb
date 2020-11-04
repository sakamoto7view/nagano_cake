Rails.application.routes.draw do
  devise_for :admin, skip: :all
  devise_scope :admin do
    get 'admin/sign_up' => 'devise/registrations#new'
    post 'admin' => 'devise/registrations#create'
    get 'admin/sign_in' => 'admin/devise/sessions#new'
    post 'admin/sign_in' => 'admin/devise/sessions#create'
    delete 'admin/sign_out' => 'devise/sessions#destroy'
    post 'admin/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :customers, controllers: {
      sessions:      'customers/sessions',
      passwords:     'customers/passwords',
      registrations: 'customers/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "items#top"

      resources :items, only: [:top, :index, :show]
      resources :addresses, only: [:index, :create, :edit, :update]
      delete '/addresses/:id' => 'addresses#destroy', as: 'destroy_address'

      get '/customers/:id' => 'customers#show'
      resources :customers, only: [:edit, :update] do
        member do #https://qiita.com/tt_tsutsumi/items/588d0e65a289a15530d2
            get "unsubscribe"
            #ユーザーの会員状況を取得
            patch "withdrawl"
            #ユーザーの会員状況を更新
        end
      end


      resources :orders, only: [:index, :create, :show, :new]
      get '/order/confirm' => 'orders#confirm', as: 'order_confirm'
      get '/complete' => 'orders#complete', as: 'order_complete'


      resources :cart_items, only: [:index, :create, :destroy, :update]
      delete :cart_items, to: 'cart_items#destroy_all'

    namespace :admin do
      resources :items, only: [:index, :new, :create, :show,  :edit, :update]
      resources :genres, only: [:index, :create, :edit, :update]
      resources :orders, only: [:index, :show, :update] do
        resources :order_details, only: [:update]
      end
      resources :customers, only: [:index, :show,  :edit, :update]
    end
    
    get '/admin/top' => 'admin#top'


    get '/about' => 'abouts#top'

end
