Rails.application.routes.draw do
  
  resources :age_ranges
  resources :events
  resources :faqs

  # TODO (Rails 6.0): the dynamic :controller route below must be replaced
  # with explicit routes for each remaining catch-all-served controller
  # (audio, welcome non-root actions, login, user, admin). Search views
  # for link_to/url_for callers to enumerate the URLs in use.
  
  root :to => 'welcome#index'
  
  match '/login' => 'login#login', via: :get
  match '/registration' => 'registration#index', via: :get
  match '/registration/register' => 'registration#register', via: :get

  # todo: revisit this and make explicit routes for each controller
  match '/:controller(/:action(/:id(.:format)))',
        via: [:get, :post],
        constraints: { controller: /audio|welcome|age_ranges|events|login|user|admin|faqs|registration/ }
  
end
