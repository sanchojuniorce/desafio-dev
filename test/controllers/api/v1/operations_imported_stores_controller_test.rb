require "test_helper"

class Api::V1::OperationsImportedStoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_operations_imported_stores_index_url
    assert_response :success
  end
end
