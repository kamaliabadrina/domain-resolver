require "test_helper"

class ResolverControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get resolver_index_url
    assert_response :success
  end
end
