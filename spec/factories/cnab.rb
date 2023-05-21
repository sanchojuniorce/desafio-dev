FactoryBot.define do
  factory :cnab do
    shop_owner { "JOÃO MACEDO" }
    store { "BAR DO JOÃO" }
    transaction_type { 3 }
    date_occurrence { "2019-03-01" }
    movement_value { 10000011.2 }
    cpf_beneficiary { "00962067601" }
    card_transaction { "73648****009" }
    hour_transaction { "2000-01-01T23:42:34.000Z" }
    association(:importer_data_cnab)
  end
end