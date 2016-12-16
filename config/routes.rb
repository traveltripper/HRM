Rails.application.routes.draw do
  
  resources :nominations
  resources :cpp
  resources :healthinsurances
  resources :announcements
  resources :payrolls
  resources :events
  resources :events
  resources :conference_rooms

  get 'alerts/index'
  get '/employees' => 'employees#index'
  get 'get_current_employee_role' => "employees#get_current_employee_role"

  devise_scope :employee do
   get "login", to: "devise/sessions#new"
   get "logout", to: "devise/sessions#destroy"
  end

  root :to => 'hrmdashboard#index'

  devise_for :employees, :skip => [:registrations]                                          
  as :employee do
    get 'password/edit' => 'devise/registrations#edit', :as => 'edit_employee_registration'    
    put 'employees' => 'devise/registrations#update', :as => 'employee_registration'            
  end

  resources :employees do
    get :birthdays, on: :collection
    post :import, on: :collection 
    get 'send_welcome_email'
    get 'get_leave_used'
    post 'update_leave_used'

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
      get :leave_status_approve
      patch :leave_status_reject
      get :leave_details
      get :leave_cancel
      get :leave_reject
      get :cancel_approved_leave
    end
  end

  resources :hrmdashboard do
    member do
      get :employee_details   
      #get 'team'   
    end
  end
  
  get '/dashboard' => 'hrmdashboard#index'

  #get 'profile' => 'employees#profile'
  get '/profile' => 'hrmdashboard#profile'

  get '/hrm_leave' => 'hrmdashboard#leave'

  #get '/team' => 'employees#team'
  get '/team' => 'hrmdashboard#team'
  get '/team_leave' => 'leave#leave_applied_by_team'
  get '/employees_leave' => 'leave#leave_applied_by_employees'  
  get '/birthdays' => 'employees#birthdays'
  get 'search' => 'employees#search'
  get '/alerts' => 'alerts#index'
  post '/alerts' => 'alerts#index'
  post '/sendmail' => 'alerts#sendmail'
  get '/edit_profile' => 'employees#edit_profile'
  patch '/update_profile' => 'employees#update_profile'
  get 'alerts/search' => 'alerts#search'
  get '/get_emails' => 'employees#get_emails_and_name'
  get 'hrm_events' => 'hrmdashboard#events'
  get '/hrm_payroll' => 'hrmdashboard#payroll'
  get '/download_payslip' => 'payrolls#download_payslip'
  get '/change_password' => 'employees#change_password'
  post '/update_password' => 'employees#update_password'
  get '/company-events' => 'events#company_events'
  get '/team-events' => 'events#team_events'
  get 'team-leave-details' => 'leave#team_leave_details'
  get '/cpp' => 'cpps#index'
end
