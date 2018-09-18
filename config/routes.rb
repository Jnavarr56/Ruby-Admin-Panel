Rails.application.routes.draw do
  root 'dashboard#index'

  get '/dashboard', to: 'dashboard#index'
  


  resources :section_materials
  resources :materials
  resources :grades
  resources :assignments
  resources :users
  resources :enrollments
  resources :sections
  resources :courses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
