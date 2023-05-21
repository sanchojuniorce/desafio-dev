module ImporterDataCnabControllerConcern
  extend ActiveSupport::Concern

  included do

    def get_shop_owner(name_establishment, arr_line)
      data_customer = verify_name(name_establishment)
      surname = data_customer.present? ? data_customer[0] : name_establishment
      "#{arr_line[0][48..]} #{surname}"
    end  
  
    def get_movement_value(value_movement)
      (value_movement.to_f / 100.00)
    end  
  
    def get_hour_transaction(part_hour) 
      "#{part_hour[42..43]}:#{part_hour[44..45]}:#{part_hour[46..47]}"
    end  
  
    def get_store(part_data_customer, part_name_store)
      "#{part_data_customer} #{part_name_store.join(" ")}"
    end  
  
    def get_date_occurrence(date_part)
      Date.parse("#{date_part[7..8]}/#{date_part[5..6]}/#{date_part[1..4]}")
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
  
    def insert_data_cnab(importer_data_cnab)
      if importer_data_cnab.present?
        file = importer_data_cnab.document
        path = ActiveStorage::Blob.service.path_for(file.key)
  
        arr_file = []
        File.readlines(path).each do |line|
          arr_line = line.split(" ")
          data_customer = verify_name(arr_line[1])        
  
          shop_owner = get_shop_owner(arr_line[1], arr_line)
          store = get_store(data_customer[1], arr_line[2..])
          transaction_type = arr_line[0][0].to_i
          date_occurrence = get_date_occurrence(arr_line[0]) 
          movement_value = get_movement_value(arr_line[0][8..17])
          cpf_beneficiary = arr_line[0][18..28]
          card_transaction = arr_line[0][29..40] 
          hour_transaction = get_hour_transaction(arr_line[0])
          
          Cnab.create(shop_owner: shop_owner, store: store.strip, transaction_type: transaction_type, 
            date_occurrence: date_occurrence, movement_value: movement_value, 
            cpf_beneficiary: cpf_beneficiary, card_transaction: card_transaction,
            hour_transaction: hour_transaction, importer_data_cnab_id: importer_data_cnab.id
          )
        end  
      end
    end 
      
  end
end

