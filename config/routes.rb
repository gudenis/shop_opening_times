Rails.application.routes.draw do
  resources :shop, only: [:index, :show]
end
