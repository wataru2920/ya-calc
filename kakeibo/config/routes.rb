Rails.application.routes.draw do
  resources :calcs
  post 'calcs/select'
  post 'calcs/squeeze'
  get 'graph/:id' => 'calcs#graph'

  get 'users/new'
  post 'users/create'
  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  get 'logout' => 'users#logout'

  get '/' => "home#top"
end
