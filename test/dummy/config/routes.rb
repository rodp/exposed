Rails.application.routes.draw do
  mount Exposed::Engine => "/exposed"

  resources :posts
end
