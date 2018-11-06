Rails.application.routes.draw do
  get '/' => 'posts#index'
  get '/posts/new' => 'posts#new'
  get '/posts/:id/edit' => 'posts#edit'
  get '/posts/:id/list' => 'posts#list'

  post '/posts/create' => 'posts#create'
  post '/posts/:id/update' => 'posts#update'
  post '/posts/:id/destroy' => 'posts#destroy'

  get 'user/new' => "user#new"
  get 'user/login_form' => "user#login_form"
  get 'user/logout' => "user#logout"
  get 'user/:id/edit' => "user#edit"
  get 'user/list' => "user#list"

  post 'user/create' => "user#create"
  post 'user/login' => "user#login"
  post 'user/:id/update' => "user#update"
end
