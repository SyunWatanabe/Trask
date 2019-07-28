Rails.application.routes.draw do
  root 'pages#home'
  get    'home',    to: 'pages#home'
  get    'about',   to: 'pages#about'
  get    'help',    to: 'pages#help'
  post  'testlogin',to: 'pages#create'
  get    'signup',  to: 'users#new'
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  get    'search',  to: 'questions#search'
  get    'questions/rank',   to: 'questions#rank'
  get    'answers/rank',   to: 'answers#rank'
  resources :users
  resources :questions do
   resources :answers
  end
  resources :likes, only: [:create, :destroy]
  resources :answers do
    resources :comments, only: [:create, :destroy]
  end
  
end
