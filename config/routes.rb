Rails.application.routes.draw do
  root "importer_data_cnab#new"

  get 'importer_data_cnab/index'
  get 'importer_data_cnab/new'
  post 'importer_data_cnab/create'
end
