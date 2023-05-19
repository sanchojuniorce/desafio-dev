class ImporterDataCnabController < ApplicationController

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

  def insert_data_cnab(importer_data_cnab)
    if importer_data_cnab.present?
      file = importer_data_cnab.document
      path = ActiveStorage::Blob.service.path_for(file.key)

      arr_file = []
      File.readlines(path).each do |line|
        arr_line = line.split(" ")
        cod = arr_line[0][0..33]
        cod_2 = arr_line[0][38..47]
        verify_name(arr_line[1])
        #raise ["MERCADO", "LOJA"].include?(arr_line[1]).inspect
        if ["MERCADO", "LOJA"].include?(arr_line[1])
          verify_name(arr_line[1])
          name = "#{arr_line[0][48..]} #{arr_line[1]}"
          establishment = arr_line[2..].join(" ")
        end  
        # Cnab.create(cod1: cod, cod2: cod_2, name: name, 
        #   establishment: establishment, importer_data_cnab_id: importer_data_cnab.id
        # )
      end  
    end
  end  

  def verify_name(name_establishment)
    if name_establishment.present?
      #debugger
      if ["MERCADO", "LOJA"].any? { |word| name_establishment.include?(word) }
        name_establishment.chomp("LOJA")
        name_establishment.chomp("MERCADO")
        raise name_establishment.inspect
      end  
    end  
  end  

  private

  # Only allow a list of trusted parameters through.
  def importer_data_cnab_params
    params.require(:importer_data_cnab).permit(:document)
  end
end
