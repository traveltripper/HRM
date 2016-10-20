Rails.application.routes.draw do
  get '/hrmdashboard' => 'hrmdashboard#index'

  resources :announcements
  resources :payrolls
  get 'alerts/index'

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
      get :manager
    end
  end

  resources :leavetypes
  resources :leave do
    member do
      patch :leave_status
    end
  end

  get '/team' => 'employees#team'
  get '/leave-applied-by-team' => 'leave#leave_applied_by_team'
  # match '/departments/:id/employees' => 'departments#employees', via: [:get, :post]
  
  get '/birthdays' => 'employees#birthdays'
  get 'search' => 'employees#search'
  get '/alerts' => 'alerts#index'
  post '/alerts' => 'alerts#index'
  post '/sendmail' => 'alerts#sendmail'
  get '/edit_profile' => 'employees#edit_profile'
  patch '/update_profile' => 'employees#update_profile'

  get 'alerts/search' => 'alerts#search'
  get '/get_emails' => 'employees#get_emails_and_name'
  #get '/leave_status' => 'leave#leave_status'
  #patch '/leave_status' => 'leave#leave_status'

  get 'hrm_team' => 'hrmdashboard#team'
  get 'hrm_leave' => 'hrmdashboard#leave'
end
