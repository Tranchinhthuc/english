Rails.application.routes.draw do
  root   'static_pages#home'
  get    'signup'    => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'help'  =>  'static_pages#help'
  resources :courses do
    resources :subjects do
      resources :tasks do
        resources :tests do
          resources :choice_questions do
            resources :answers
          end
        end
      end
    end
  end
  namespace :supervisor do
    resources :users
  end
end
