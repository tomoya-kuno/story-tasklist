Rails.application.routes.draw do
  
  root to: 'tasks#index'
  resources :tasks
  # ↑の中身
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
end
