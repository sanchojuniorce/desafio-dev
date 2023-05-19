class CreateCnabs < ActiveRecord::Migration[7.0]
  def change
    create_table :cnabs do |t|
      t.string :name
      t.string :cod1
      t.string :cod2
      t.string :establishment
      t.references :importer_data_cnab, null: true, index: true, foreign_key: true

      t.timestamps
    end
  end
end
