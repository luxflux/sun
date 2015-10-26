Rails.application.routes.draw do
  resources :locations, only: %i(index show) do
    resources :ports, shallow: true
    resources :ports, as: :inputs, shallow: true
    resources :ports, as: :outputs, shallow: true
  end
  resources :metrics, only: %i(show)
  root to: redirect('locations#index')
end
