Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

 
 namespace :admin do
   get  "/" => "homes#top"
   resources :items, only: [:index, :new, :create, :show, :edit, :update]
   resources :genres, only: [:index, :create, :edit, :update]
   resources :customers, only: [:index, :show, :edit, :update]
   resources :orders, only: [:show, :update]
   resources :ordered_products, only: [:update]
 end
 scope module: 'public' do
  get "/" => "homes#top"
  get "/about" => "homes#about", as: "about"
 resources :items, only: [:index, :show]
 get "/customers/my_page" => "customers#show"
 get "/customers/information/edit" => "customers#edit"
 patch "/customers/information" => "customers#update"
 get "/customers/unsubscribe" => "customers#unsubscribe" #顧客の退会確認画面
 patch "/customers/withdrawal" => "customers#withdrawal", as: "withdrawal_customers"#顧客の退会処理(ステータスの更新)
 put "/customers/withdrawal" => "customers#withdrawal"
 resources :cart_items, only: [:index, :update, :create, :destroy]
 delete "/cart_items" => "cart_items#destroy_all" #カート内商品データ削除(全て)
 resources :orders, only: [:new, :create, :index, :show]
 post "/orders/confirm" => "orders#confirm" #注文情報確認画面
 get "/orders/complete" => "orders#complete" #注文完了画面
 resources :addresses, only: [:index, :edit, :create, :update, :destroy]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
