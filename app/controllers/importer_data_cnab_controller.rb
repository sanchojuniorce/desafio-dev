class ImporterDataCnabController < ApplicationController

  def index
    @importer_data_cnab = ImporterDataCnab.find(18)
    file = @importer_data_cnab.document
    path = ActiveStorage::Blob.service.path_for(file.key)

    arr_file = []
    File.readlines(path).each do |line|
      arr_line = line.split(" ")
      cod = arr_line[0][0..33]
      cod_2 = arr_line[0][38..47]
      name = "#{arr_line[0][48..]} #{arr_line[1..].join(" ")}"
      arr_file << {cod: cod, cod_2: cod_2, name: name}
    end
    
    @importer_data_cnab = arr_file
  end

  def new 
  end

  def create
    @importer_data_cnab = ImporterDataCnab.new(importer_data_cnab_params)
    if @importer_data_cnab.save
      insert_data_cnab(@importer_data_cnab)
      flash[:success] = I18n.t('messages.creation.success.female', object_label: ImporterDataCnab.model_name.human)
      redirect_to importer_data_cnab_index_path(@importer_data_cnab)
    else
      render :new
    end
  end

  def insert_data_cnab(importer_data_cnab)
    if importer_data_cnab.present?
      file = importer_data_cnab.document.download
      raise file.readlines.map(&:chomp).split.inspect
    end  
  end  

  private

  # Only allow a list of trusted parameters through.
  def importer_data_cnab_params
    params.require(:importer_data_cnab).permit(:document)
  end
end
