Rails.application.routes.draw do
  root to: 'leads#index'
  devise_for :users
  resources :users do
    collection { post :import }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :leads
  get 'interviews' => 'leads#interviews'
  get 'job_offers' => 'leads#job_offers'

  # route that sendgrid will POST to for creating a new lead via email
  mount_griddler
end
