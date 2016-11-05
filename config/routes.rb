Rails.application.routes.draw do
    devise_for :users

    resources :products do
        member do
            post :add_to_cart
        end
    end

    namespace :admin do
        resources :products do
            member do
                post :hide
                post :publish
            end
        end
        resources :orders
    end

    resources :orders do
        member do
            post :pay_with_alipay
            post :pay_with_wechat
            post :cancell
            post :ship
        end
    end

    resources :carts do
        collection do
            post :checkout
        end
    end
    namespace :account do
        resources :orders do
            member do
                post :cancell
            end
        end
    end
    resources :cart_items do
        member do
            post :add
            post :minus
        end
    end

    root 'products#index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
