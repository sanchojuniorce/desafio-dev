require "test_helper"

class ImporterDataCnabControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get importer_data_cnab_index_url
    assert_response :success
  end

  test "should get create" do
    get importer_data_cnab_create_url
    assert_response :success
  end
end
