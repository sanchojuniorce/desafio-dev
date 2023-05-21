class ImporterDataCnabController < ApplicationController
  include ImporterDataCnabControllerConcern

  def index
    @importer_data_cnab = Cnab.where(importer_data_cnab_id: params[:id])
  end

  def new 
  end

  def create
    @importer_data_cnab = ImporterDataCnab.new(importer_data_cnab_params)
    if @importer_data_cnab.save
      insert_data_cnab(@importer_data_cnab)
      flash[:success] = I18n.t('messages.creation.success.female', object_label: ImporterDataCnab.model_name.human)
      redirect_to index_path(id: @importer_data_cnab.id)
    else
      render :new
    end
  end  

  private

  # Only allow a list of trusted parameters through.
  def importer_data_cnab_params
    params.require(:importer_data_cnab).permit(:document)
  end

end
