require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get teste" do
    get pages_teste_url
    assert_response :success
  end

end
