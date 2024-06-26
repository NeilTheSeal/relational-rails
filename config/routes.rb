Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # group by controller

  get "/", to: "index#index"
  get "/schools", to: "schools#index"
  get "/schools/new", to: "schools#new"
  post "/schools", to: "schools#create"
  patch "/schools/:id", to: "schools#update"
  get "/schools/:id", to: "schools#show"
  get "/schools/:id/edit", to: "schools#edit"
  delete "/schools/:id", to: "schools#destroy"
  get "/students", to: "students#index"
  get "/students/:id", to: "students#show"
  delete "/students/:id", to: "students#destroy"
  patch "/students/:id", to: "students#update"
  get "/students/:id/edit", to: "students#edit"
  get "/schools/:id/students", to: "school_students#index"
  post "/schools/:id/students", to: "school_students#create"
  get "/schools/:id/students/new", to: "school_students#new"
end
