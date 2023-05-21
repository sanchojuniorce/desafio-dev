require 'swagger_helper'

RSpec.describe 'api/v1/operations_imported_stores', type: :request do

  path '/api/v1/operations_imported_stores/index' do

    get('list operations_imported_stores') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
