class CreateCnabs < ActiveRecord::Migration[7.0]
  def change
    create_table :cnabs do |t|
      t.string :shop_owner
      t.string :store
      t.integer :transaction_type
      t.date :date_occurrence
      t.decimal :movement_value, precision: 10, scale: 2
      t.string :cpf_beneficiary
      t.string :card_transaction
      t.time :hour_transaction
      t.references :importer_data_cnab, null: true, index: true, foreign_key: true

      t.timestamps
    end
  end
end
