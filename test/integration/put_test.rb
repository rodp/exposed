require 'test_helper'

class PutTest < ActionDispatch::IntegrationTest
  fixtures :all

  include ExposedTestDSL

  test "should PUT model" do
    @data = { "title" => "Changed post", "content" => "Content of the changed post" }
    put "/posts/2", @data.to_json, { "CONTENT_TYPE" => 'application/json', "ACCEPT" => "application/json" }

    # Did we get something?
    assert_response :success

    # Did we get a hash?
    assert_hash

    # Did we get all the attributes?
    assert_attrs

    # Are attributes values changed?
    assert_values
  end
end

