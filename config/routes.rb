Rails.application.routes.draw do
  # get 'dashboard/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"

  resources :dashboard, only: [] do
  	collection do
  		get :chart_data
    end
  end
end
