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
    put '/:id' => :update
    get '/:id' => :show, as: :task_show
    get 'show_users/:id' => :show_users_task, as: :show_users_task
    delete 'add_users/:id_user/:id_task' => :delete_users, as: :task_user_delete
    put 'add_users/:id_task' => :create_users_for_task, as: :task_user_create
    delete ':id' => :destroy, as: :task_delete
    get 'type/:all' => :view_all_tasks, as: :view_all_tasks
  end

  resources :sessions do
    resources :users
  end

  resources :users do
    resources :tasks
  end
end
