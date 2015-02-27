Rails.application.routes.draw do
  root   'static_pages#home'
  get    'signup'    => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'help'  =>  'static_pages#help'
  resources :courses do
    get "addsubject"
  end
  resources :subjects do
    get "addtask"
  end
  resources :tasks do
    get "addtest"
  end
  resources :tests do
    get "addquestion"
  end
  resources :choice_questions
  resources :users
  resources :subjects
  resources :tasks
  resources :tests
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
    resources :choice_questions
    resources :subjects do
    get "addtask"
  end
    resources :tasks do
    get "addtest"
  end
    resources :tests do
    get "addquestion"
  end
    resources :courses do
    get "addsubject"
  end
  end
end
