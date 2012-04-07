Buckitweek::Application.routes.draw do 
  
  resources :age_ranges
  resources :events
  resources :faqs

  root :to => 'welcome#index'
  
  match '/login' => 'login#login'
  match '/registration' => 'registration#index'
  match '/registration/register' => 'registration#register'
  match '/:controller(/:action(/:id(.:format)))'
  
end
