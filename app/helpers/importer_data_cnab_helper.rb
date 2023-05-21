module ImporterDataCnabHelper
  def get_transaction(type)
    if type.present?
      if type == 1
        value =	"Débito"
      elsif type == 2
        value =	"Boleto"           
      elsif type == 3
        value =	"Financiamento"                   
      elsif type == 4
        value =	"Crédito"                           
      elsif type == 5
        value =	"Recebimento Empréstimo"                                                                         
      elsif type == 6
        value =	"Vendas"                                                   
      elsif type == 7
        value =	"Recebimento TED"                                                           
      elsif type == 8
        value =	"Recebimento DOC	Entrada"                                                           
      elsif type == 9
        value =	"Aluguel	Saída"
      end  
    end  
    value
  end
end
