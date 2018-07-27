require 'test_helper'

class ConverterTest< ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }
  empty_hash = Hash.new
  example_hash = {
    a: 1,
    b: "some string"
  }

  test "post with empty XML" do
    post "/api/convert", 
      params: empty_hash.to_xml, 
      headers: { "Content-Type" => 'application/xml' }

    assert_equal 200, response.status
    assert_equal Mime[:json], response.content_type

    assert_equal empty_hash.to_json.to_s, response.body.to_s

  end

  test "post with empty JSON" do
    post "/api/convert", 
      params: empty_hash.to_json, 
      headers: { "Content-Type" => 'application/json' }

    assert_equal 200, response.status
    assert_equal Mime[:xml], response.content_type

    assert_equal empty_hash.to_xml.to_s, response.body.to_s
  end

  test "post with an XML" do
    post "/api/convert", 
      params: example_hash.to_xml, 
      headers: { "Content-Type" => 'application/xml' }

    assert_equal 200, response.status
    assert_equal Mime[:json], response.content_type

    assert_equal example_hash.to_json.to_s, response.body.to_s

  end

  test "post with a JSON" do
    post "/api/convert", 
      params: example_hash.to_json, 
      headers: { "Content-Type" => 'application/json' }

    assert_equal 200, response.status
    assert_equal Mime[:xml], response.content_type

    assert_equal example_hash.to_xml.to_s, response.body.to_s
  end

  test "post with params" do
    post "/api/convert?a=somestring", 
      headers: { "Content-Type" => 'application/json' }

    assert_equal 400, response.status
    assert_equal Mime[:json], response.content_type

    assert_match /Bad Request/, JSON.parse(response.body)["error"]["message"]
  end

  test "get with params" do
    get "/api/convert?a=somestring", 
      headers: { "Content-Type" => 'application/json' }

    assert_equal 404, response.status

  end
end