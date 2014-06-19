Project::Application.routes.draw do
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "user_view" => "users#view", :as => "user_view"
  get "tasks" => "tasks#index", :as =>"tasks"
  get "task" => "tasks#new", :as =>"task_new"
  get "task_edit/:id" => "tasks#edit", :as =>"task_edit"
  put "task_edit/:id" => "tasks#update"
  get "task/:id" => "tasks#show", :as =>"task_show"

  get "task:id" => "tasks#destroy", :as =>"task_delete"
  root :to => "users#view"
  resources :users
  resources :sessions
  resources :tasks
end
