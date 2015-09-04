Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, path: '', only: [] do
        collection do
          post :register
          get :test_api
        end
      end
      resources :jobs, only: [:create] do
        # member do
        #   get :download
        # end
        match ':file', to: 'jobs#download', constraints: { file: /.*\..*/ }, on: :member, via: [:get]
      end
    end
  end
end
