Rails.application.routes.draw do
  get 'dashboard/index'

  resources :events
  resources :events
  resources :conference_rooms
  get 'static' => 'static#home'
  get '/employees' => 'employees#index'
  get 'get_current_employee_role' => "employees#get_current_employee_role"
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/dashboard' => 'dashboard#index'

  get '/reports' => 'employees#reports'

  get 'profile' => 'employees#profile'

  devise_scope :employee do
   get "login", to: "devise/sessions#new"
   get "logout", to: "devise/sessions#destroy"
  end

  root :to => 'dashboard#index'

  devise_for :employees, :skip => [:registrations]                                          
  as :employee do
    get 'password/edit' => 'devise/registrations#edit', :as => 'edit_employee_registration'    
    put 'employees' => 'devise/registrations#update', :as => 'employee_registration'            
  end

  resources :employees do
    get :birthdays, on: :collection
  end
  resources :roles do 
    member do
      get :employees
    end
  end

  resources :departments do 
    member do
      get :employees
    end
  end

  resources :leavetypes
  resources :leave
  get '/team' => 'employees#team'
  get '/leave-applied-by-team' => 'employees#leave_applied_by_team'
  # match '/departments/:id/employees' => 'departments#employees', via: [:get, :post]
  
  get '/birthdays' => 'employees#birthdays'
  get 'search' => 'employees#search'
end
