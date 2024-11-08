Rails.application.routes.draw do
  devise_for :employees
  resources :feedbacks
  resources :employees do
    resources :feedbacks, only: :create
  end
  root "departments#index"
  resources :departments do
    resources :employees, only: %i[new create update]
    resources :feedbacks, only: :create
  end
end
