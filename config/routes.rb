Rails.application.routes.draw do
  resources :workspaces

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

  root to: "home#new_index"

  get 'selected/group/:group_id', to: 'home#selected_group'
  get 'selected/task/:task_id', to: 'home#selected_task'
  get 'from_mail/:task_id/:group_id', to: 'home#from_mail'

  # get ':user_id', to: 'home#new_index'
  get ':user_id', to: 'home#new_index'
  get ':user_id/:workspace_id', to: 'home#new_index'
  get ':user_id/:workspace_id/:group_id', to: 'home#new_index'
  get ':user_id/:workspace_id/:group_id/:task_id', to: 'home#new_index'

end
