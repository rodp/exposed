require 'test_helper'

class PostTest < ActionDispatch::IntegrationTest
  fixtures :all

  include ExposedTestDSL

  test "should POST model" do
    @data = { "title" => "Third post", "content" => "Content of the third post" }
    post "/posts", @data.to_json, { "CONTENT_TYPE" => 'application/json', "ACCEPT" => "application/json" }

    # Did we get something?
    assert_response :success

    # Did we get a hash?
    assert_hash

    # Did we get all the attributes?
    assert_attrs

    # Are attribute values right?
    assert_values
  end
end

