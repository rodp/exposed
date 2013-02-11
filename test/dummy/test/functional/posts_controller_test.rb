require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def logger
    ::Rails.logger
  end

  test "should get collection" do
    get :index
    logger.debug "Helloooo"
    assert_response :success
    #assert_not_nil assigns(:posts)
  end
end
