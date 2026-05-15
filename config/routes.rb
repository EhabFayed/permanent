Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  post 'signup', to: 'authentication#signup'
  post 'login', to: 'authentication#login'
  put    'users/:id',   to: 'authentication#update'
  resources :blogs, only: [:index, :show, :create, :update, :destroy] do
    resources :faqs, only: [:index, :create, :update, :destroy]
    resources :contents, only: [:index, :create, :update, :destroy]
  end
  resources :products, only: [:index, :show, :create, :update, :destroy]
  get "blogs_landing", to: "web_site#blogs_landing"
  get "blog_show/", to: "web_site#blog_show"
  get "products_website", to: "web_site#products"
  get '/faq_about_us', to: 'web_site#faq_about_us'
  get '/faqs', to: 'faqs#index_without_blog'
  post '/faqs', to: 'faqs#create_without_blog'
  put '/faqs/:id', to: 'faqs#update_without_blog'
  delete '/faqs/:id', to: 'faqs#delete_without_blog'
  # Defines the root path route ("/")
  # root "posts#index"
end
