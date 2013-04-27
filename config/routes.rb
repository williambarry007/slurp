Slurp::Application.routes.draw do |map|  
#Rails.application.routes.draw do
  
  get     "users"           => "slurp/users#index"
  get     "users/:id"       => "slurp/users#show"
  get     "users/:id/edit"  => "slurp/users#edit"
  put     "users/:id"       => "slurp/users#update"
  get     "users/new"       => "slurp/users#new"
  post    "users"           => "slurp/users#create"
  delete  "users/:id"       => "slurp/users#destroy"
      
  get     "login"           => "login#index"
  post    "login"           => "login#login"
  get     "logout"          => "logout#index"
  
  get     "users"           => "slurp/users#index"
  get     "users/:id"       => "slurp/users#show"
  get     "users/:id/edit"  => "slurp/users#edit"
  put     "users/:id"       => "slurp/users#update"
  get     "users/new"       => "slurp/users#new"
  post    "users"           => "slurp/users#create"
  delete  "users/:id"       => "slurp/users#destroy"
  
  get     "roles"           => "slurp/roles#index"
  get     "roles/options"   => "slurp/roles#options"
  get     "roles/:id"       => "slurp/roles#show"
  get     "roles/:id/edit"  => "slurp/roles#edit"
  put     "roles/:id"       => "slurp/roles#update"
  get     "roles/new"       => "slurp/roles#new"
  post    "roles"           => "slurp/roles#create"
  delete  "roles/:id"       => "slurp/roles#destroy"
  
  get     "permissions"           => "slurp/permissions#index"
  get     "permissions/:id"       => "slurp/permissions#show"
  get     "permissions/:id/edit"  => "slurp/permissions#edit"
  put     "permissions/:id"       => "slurp/permissions#update"
  get     "permissions/new"       => "slurp/permissions#new"
  post    "permissions"           => "slurp/permissions#create"
  delete  "permissions/:id"       => "slurp/permissions#destroy"
  
end

