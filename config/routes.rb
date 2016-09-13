Rails.application.routes.draw do
  get 'employees/index'

  get 'employees/show'

  get 'reports/index'

  get 'dashboard/index'


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/dashboard' => 'employees#dashboard'

  get '/reports' => 'employees#reports'

  get 'profile' => 'employees#show'

  get 'login' => redirect("/employees/sign_in")

  root :to => 'employees#dashboard'

  # devise_scope :employees do
  #   authenticated :employees do
  #     root 'static_pages#home', as: :authenticated_root
  #   end

  #   unauthenticated do
  #     root :to => redirect("/employees/sign_in")
  #   end
  # end

  devise_for :employees, :skip => [:registrations]                                          
  as :employee do
    get 'employees/edit' => 'devise/registrations#edit', :as => 'edit_employee_registration'    
    put 'employees' => 'devise/registrations#update', :as => 'employee_registration'            
  end

end
