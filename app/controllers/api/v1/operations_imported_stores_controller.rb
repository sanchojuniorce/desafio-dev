class Api::V1::OperationsImportedStoresController < ApplicationController

  def index
    @stores = Cnab.where(store: params[:store])
    account_balance_totalizer = @stores.map{|store| store.movement_value}.sum
    render json: {stores: @stores, account_balance_totalizer: account_balance_totalizer}
  end
end
