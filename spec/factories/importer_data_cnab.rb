FactoryBot.define do
  factory :importer_data_cnab do
    document { 
      Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/cnab.txt")
    }
  end
end
