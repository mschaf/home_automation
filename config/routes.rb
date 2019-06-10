Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :actors do
    member do
      get :on
      get :off
    end
  end

  resources :schedules

  resources :executions, only: [:create]
  resources :things, only: [:index, :show]

end
