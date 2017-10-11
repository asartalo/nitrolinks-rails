Rails.application.routes.draw do
  resources :nitrolinks, only: [:index] do
    collection do
      get 'link1'
      get 'redirecting'
      get 'redirected'
      get 'changing'
      get 'error_500'
      post 'changing_post'
      post 'blank'
    end
  end
end
