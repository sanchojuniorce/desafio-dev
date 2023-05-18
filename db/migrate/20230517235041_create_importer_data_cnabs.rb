class CreateImporterDataCnabs < ActiveRecord::Migration[7.0]
  def change
    create_table :importer_data_cnabs do |t|
      t.string :document

      t.timestamps
    end
  end
end
