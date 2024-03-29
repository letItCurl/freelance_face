# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get 'home/index'

  authenticate :user, ->(u) { u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")

  scope module: :back_office do
    resources :resumes_replicas
    resource :resume, only: %i[update edit]

    resources :resumes, only: [] do
      member do
        resources :experiences, only: [:create]
      end
    end

    resources :experiences, only: [:destroy]
  end


  scope module: :front_office do
    get "/:username/:resume_id", to: "resumes#show", as: :public_resume
  end

  devise_scope :user do
    authenticated do
      root to: 'back_office/resumes_replicas#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'home#index'
    end
  end
end
