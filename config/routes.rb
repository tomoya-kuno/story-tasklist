Rails.application.routes.draw do
  
  root to: 'toppages#index'
  resources :tasks do
  # resources :tasksの中身
  # # CRUD
  # get 'tasks/:id', to: 'tasks#show'
  # post 'tasks', to: 'tasks#create'
  # put 'tasks/:id', to: 'tasks#update'
  # delete 'tasks/:id', to: 'tasks#destroy'
  # # 一覧ページ(index)の追加 ← 詳細ページ(show)
  # get 'tasks', to: 'tasks#index'
  # # 新規作成用のフォームページ(new)
  # get 'tasks/new', to: 'tasks#new'
  # # 編集用のフォームページ(edit)
  # get 'tasks/:id/edit', to: 'tasks#edit'
  collection do
      get 'calendar', to: 'tasks#calendar'
      get 'custom', to: 'tasks#custom'
    end
  end
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only:[:new,:create,:edit,:update]
  
  resources :stories
end
