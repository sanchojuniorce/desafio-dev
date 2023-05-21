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

        data_customer = verify_name(arr_line[1])
        surname = data_customer.present? ? data_customer[0] : arr_line[1]

        shop_owner = "#{arr_line[0][48..]} #{surname}"
        store = "#{data_customer[1]} #{arr_line[2..].join(" ")}"
        transaction_type = arr_line[0][0].to_i
        date_occurrence = Date.parse("#{arr_line[0][7..8]}/#{arr_line[0][5..6]}/#{arr_line[0][1..4]}")
        movement_value = (arr_line[0][8..17].to_f / 100.00)
        cpf_beneficiary = arr_line[0][18..28]
        card_transaction = arr_line[0][29..40] 
        hour_transaction = "#{arr_line[0][42..43]}:#{arr_line[0][44..45]}:#{arr_line[0][46..47]}" #.to_time #.strftime("%H:%M:%S").class
        
        Cnab.create(shop_owner: shop_owner, store: store.strip, transaction_type: transaction_type, 
          date_occurrence: date_occurrence, movement_value: movement_value, 
          cpf_beneficiary: cpf_beneficiary, card_transaction: card_transaction,
          hour_transaction: hour_transaction, importer_data_cnab_id: importer_data_cnab.id
        )
      end  
    end
  end  

  def verify_name(name_establishment)
    arr_data_cnab = []
    if name_establishment.present?
      if ["MERCADO", "LOJA"].any? { |word| name_establishment.include?(word) }
        name_customer = name_establishment.chomp("LOJA")
        name_customer = name_customer.chomp("MERCADO")
        establishment = "LOJA".in?(name_establishment) ? "LOJA" : "MERCADO"
        arr_data_cnab << name_customer
        arr_data_cnab << establishment
      end
    end  
    arr_data_cnab
  end  

  private

  # Only allow a list of trusted parameters through.
  def importer_data_cnab_params
    params.require(:importer_data_cnab).permit(:document)
  end
end
