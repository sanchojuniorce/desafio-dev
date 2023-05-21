Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get 'operations_imported_stores/index'
    end
  end
  root "importer_data_cnab#new"

  get 'index', to: 'importer_data_cnab#index', as: :index
  get 'new', to: 'importer_data_cnab#new', as: :new
  post 'importer_data_cnab/create'
end
