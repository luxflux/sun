Rails.application.routes.draw do

  resources :rules
  resources :locations, only: %i(index show) do
    resources :ports, shallow: true do
      resources :action_log_entries, only: %i(index), path: :log
    end
    resources :ports, as: :inputs, shallow: true
    resources :ports, as: :outputs, shallow: true
  end
  resources :metrics, only: %i(show)
  root to: redirect('locations#index')
end
