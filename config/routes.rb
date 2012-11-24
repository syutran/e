E::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  get "manage_money" => "users#manage_money", :as => "manage_money"
  put "update_event" => "events#update_event", :as => "update_event"

  get "rule_show_records" => "rules#rule_show_records", :as => "rule_show_records"

  get "records_list" => "records#records_list", :as => "records_list"

  get "find_users" => "friends#find_users", :as => "find_users"
  get "read_msgs" => "friends#read_msgs", :as => "read_msgs"

  post "storages_list" => "storages#storages_list", :as => "storages_list"
  get "storages_list" => "storages#storages_list", :as => "storages_list"
  
  get "get_doing_records" => "records#get_doing_records", :as => "get_doing_records"
  get "get_new_records" => "records#get_new_records", :as => "get_new_records"
  get "group_rules" => "records#get_group_rules", :as => "get_group_rules"
  get "get_public_rules" => "records#get_public_rules", :as => "get_public_rules"

  resources :users
  resources :sessions
  resources :categories, :only => [:index, :show, :select_sub]
  namespace :admin do |admin|
    resources :categories
  end
  resources :user_categories
  resources :storages
  resources :rules
  resources :events
  resources :records
  resources :friends

  # root :to => "rules#home"
  root :to => "sessions#new"

  match ':controller(/:action(/:id(.:format)))'
end
