Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    get '/', to: 'pages#dashboard'
    resources :users, :games, :categories, :user_games, :pacmen
  end
  resources :categories, only: %i[index]
  resources :games, only: [:show], param: :name do
    resources :user_games, only: %i[show create new]
    resources :pacmen, only: %i[create new]
  end
  resources :user_games, only: %i[index]
  post 'word_validation', to: 'liste_de_mots#word_validation'
end
