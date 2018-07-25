Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

<<<<<<< HEAD
  get "/" => "welcome#index", as: "root"

  constraints Clearance::Constraints::SignedIn.new do
    root to: "deals#index"
  end
=======
  get "/" => "welcome#index"

  # constraints Clearance::Constraints::SignedIn.new do
  #   root to: 'welcome#index', as: :root
  # end
>>>>>>> master

  constraints Clearance::Constraints::SignedOut.new do
    root to: "clearance/sessions#new"
  end

resources :deals

resources :welcome, only: [:index]

resources :companies

patch "deals/:id/spin" => "deals#spin", as: "spin"

end
