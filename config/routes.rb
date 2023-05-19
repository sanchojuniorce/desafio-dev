Rails.application.routes.draw do
  root "importer_data_cnab#new"

  get 'index', to: 'importer_data_cnab#index', as: :index
  get 'new', to: 'importer_data_cnab#new', as: :new
  post 'importer_data_cnab/create'
end
