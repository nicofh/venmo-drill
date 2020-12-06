Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  ExceptionHunter.routes(self)
  mount_devise_token_auth_for 'User', at: '/api/v1/users', controllers: {
    registrations: 'api/v1/registrations',
    sessions: 'api/v1/sessions',
    passwords: 'api/v1/passwords'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :settings, only: [] do
        get :must_update, on: :collection
      end

      resources :users, only: %i[update show] do
        scope module: :users do
          resources :payment, only: [:create], controller: :payments
        end
      end
    end
  end
end
