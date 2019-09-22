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
  get    'questions/category/id',   to: 'questions#category'
  get    'questions/subcategory/id',   to: 'questions#subcategory'
  resources :users
  resources :questions do
   resources :answers
  end
  resources :likes, only: [:create, :destroy]
  resources :answers do
    resources :comments, only: [:create, :destroy]
  end
  resources :categories, only: [] do
    resources :sub_categories, only: :index
  end
end
