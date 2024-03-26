Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/", to: "index#index"
  get "/schools", to: "schools#index"
  get "/schools/new", to: "schools#new"
  post "/schools", to: "schools#create"
  patch "/schools/:id", to: "schools#update"
  get "/schools/:id", to: "schools#show"
  get "/schools/:id/students", to: "school_students#index"
  post "/schools/:id", to: "school_students#create"
  get "/schools/:id/students/new", to: "school_students#new"
  get "/schools/:id/edit", to: "schools#edit"
  get "/students", to: "students#index"
  get "/students/:id", to: "students#show"
  patch "/students/:id", to: "students#update"
  get "/students/:id/edit", to: "students#edit"
end
