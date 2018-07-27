Rails.application.routes.draw do
  # Default route for root url
  get '/', to: 'home#index'
  post '/', to: 'home#index'
  
  post '/api/convert', to: 'converter#convert'

  get "*route_not_found.:format", via: [:get, :put, :post, :patch, :delete], :to => "application#page_not_found"
  get "*route_not_found"        , via: [:get, :put, :post, :patch, :delete], :to => "application#page_not_found"
end
