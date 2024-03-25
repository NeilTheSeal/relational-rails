Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/", to: "index#index"
  get "/schools", to: "schools#index"
  get "/schools/:id", to: "schools#show"
  get "/schools/:id/students", to: "school_students#index"
  get "/students", to: "students#index"
  get "/students/:id", to: "students#show"
end
