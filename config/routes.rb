Project::Application.routes.draw do
  root :to => "users#view"

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"

  get "sign_up" => "users#new", :as => "sign_up"
  get "user_view" => "users#view", :as => "user_view"

  controller :tasks, path: 'task' do
    get '/' => :index, as: :tasks
    post '/' => :create
    get 'new' => :new, as: :task_new
    get 'edit/:id' => :edit, as: :task_edit
    get '/:id' => :show, as: :task_show
    put '/:id' => :update
    delete ':id' => :destroy, as: :task_delete
  end

  resources :sessions do
    resources :users
  end

  resources :users do
    resources :tasks
  end
end
