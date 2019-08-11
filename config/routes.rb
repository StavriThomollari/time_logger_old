Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  
  scope '/home' do
    get '/index', to: 'home#index', :as => 'home_index'
    get '/new', to: 'home#new', :as => 'new_report'
    post '/', to: 'home#create', :as => 'create_report'
  end

  devise_scope :user do
    namespace :api do
      get '/reports', to: 'report#index'
      post '/', to: 'report#create'
      post "authenticate", to: "authentication#authenticate"
    end
  end

end
