Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    # get 'sign_in',    to: 'devise/sessions#new', :as => :new_user_session
    # get 'sign_out',   to: 'devise/sessions#destroy', as: :destroy_user_session
    # get 'join',     to: 'devise/registrations#new'
    # get 'settings', to: 'devise/registrations#edit'
    # get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  get 'about', to: 'noto#about'
  get 'ui',    to: 'noto#ui'

  scope '/notes' do
    get '/', to: 'noto#index', as: 'notes'
    get '/new', to: 'note#new', as: 'new_note'
    get '/:id', to: 'notes#show', as: 'note'
  end

  root 'noto#index'
end
