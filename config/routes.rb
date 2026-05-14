Buckitweek::Application.routes.draw do 
  
  resources :age_ranges
  resources :events
  resources :faqs

  root :to => 'welcome#index'
  
  match '/login' => 'login#login', via: :get
  match '/registration' => 'registration#index', via: :get
  match '/registration/register' => 'registration#register', via: :get

  # todo: revisit this and make explicit routes for each controller
  match '/:controller(/:action(/:id(.:format)))',
        via: [:get, :post],
        constraints: { controller: /audio|welcome|age_ranges|events|login|user|admin|faqs|registration/ }
  
end
