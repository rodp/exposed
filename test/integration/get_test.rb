require 'test_helper'

class GetTest < ActionDispatch::IntegrationTest
  fixtures :all

  include ExposedTestDSL

  test "should GET collection" do
    get "/posts"

    # Did we get something?
    assert_response :success

    # Did we get an array?
    assert_array

    # Did we get all the attributes?
    assert_attrs
  end

  test "should GET collection with include" do
    get "/posts?include=comments"

    # Did we get something?
    assert_response :success

    # Did we get an array?
    assert_array

    # Did we get all the attributes?
    assert_attrs

    # Are comments one of the keys?
    assert @keys.include? "comments"

    # Are comments an array?
    assert_instance_of Array, @posts.first["comments"]
  end

  test "should GET model" do
    get "/posts/1"

    # Did we get something?
    assert_response :success

    # Did we get a hash?
    assert_hash

    # Did we get all the attributes?
    assert_attrs
  end
end

