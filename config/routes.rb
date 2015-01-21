Rails.application.routes.draw do
  resources :feeds

  resources :tasks

  resources :groups

  devise_for :users, :path => "user",
  :path_names => {
    :sign_in => 'login',
    :sign_out => 'logout',
    :password => 'secret',
    :confirmation => 'verification',
    :unlock => 'unblock',
    :registration => 'register',
    :sign_up => 'signup'
  }

  root to: "home#index"

  get 'selected/group/:group_id', to: 'home#selected_group'
  get 'selected/task/:task_id', to: 'home#selected_task'

end
