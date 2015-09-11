Rails.application.routes.draw do
  resources :locations, only: %i(index show)
  resources :metrics, only: %i(show)
  root to: redirect('locations#index')
end
