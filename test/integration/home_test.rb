require 'test_helper'

class HomeTest< ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test "go to homepage" do
    post "/"

    assert_equal 200, response.status
    assert_equal Mime[:json], response.content_type

    response_data = JSON.parse(response.body)
    assert_match /Please go to/ , response_data['message']
  end
end