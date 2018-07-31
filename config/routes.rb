Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :show, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get "/" => "welcome#index"

  # constraints Clearance::Constraints::SignedIn.new do
  #   root to: 'welcome#index', as: :root
  # end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "welcome#index"
  end

resources :deals

resources :welcome, only: [:index]

resources :companies do
  resources :reviews
end

resources :admins, only: [:index, :destroy]



patch "deals/:id/spin" => "deals#spin", as: "spin"

patch "companies/:id/verify" => "companies#verify", as: "verify"

get "companies/:id/profile" => "companies#public", as: "public"

patch "reviews/:id/report" => "reviews#report", as: "report"
get "reviews/:id/unreport" => "reviews#unreport", as: "unreport"

end
