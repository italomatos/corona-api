require 'test_helper'

class Api::V1::CoronaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_corona_index_url
    assert_response :success
  end

end
