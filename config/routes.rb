Rails.application.routes.draw do
  get '/employees' => 'employees#index'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/dashboard' => 'employees#dashboard'

  get '/reports' => 'employees#reports'

  get 'profile' => 'employees#profile'

  devise_scope :employee do
   get "login", to: "devise/sessions#new"
   get "logout", to: "devise/sessions#destroy"
  end

  root :to => 'employees#dashboard'

  devise_for :employees, :skip => [:registrations]                                          
  as :employee do
    get 'password/edit' => 'devise/registrations#edit', :as => 'edit_employee_registration'    
    put 'employees' => 'devise/registrations#update', :as => 'employee_registration'            
  end

  resources :employees do
    get :birthdays, on: :collection
  end
  resources :roles
  resources :departments
  resources :leavetypes
  resources :leave
  get '/team' => 'employees#team'
  get '/leave-applied-by-team' => 'employees#leave_applied_by_team'
  get '/birthdays' => 'employees#birthdays'
  get 'search' => 'employees#search'
end
