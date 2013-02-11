require 'test_helper'

class DeleteTest < ActionDispatch::IntegrationTest
  fixtures :all

  include ExposedTestDSL

  test "should DELETE model" do
    delete "/posts/2"

    # Did we get something?
    assert_response :success

    # Did we get a hash?
    assert_hash

    # Did we get all the attributes?
    assert_attrs

    # Is the post missing now?
    get "posts/2"
    assert_response :missing
  end
end

