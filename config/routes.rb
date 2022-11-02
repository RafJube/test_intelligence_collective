Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users, :tests, :categories, :user_tests
  end
  resources :categories, only: %i[index show], param: :name
  resources :tests, only: [:show], param: :name do
    resources :user_tests, only: %i[show create new]
  end
  resources :user_tests, only: %i[index]
  post 'word_validation', to: 'liste_de_mots#word_validation'
end
