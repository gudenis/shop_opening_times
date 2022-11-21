Rails.application.routes.draw do
  scope "(/:locale)", local: /en|fr/ do
    resources :shop, only: [:index, :show]
  end
end
