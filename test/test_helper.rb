# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../dummy/test/fixtures", __FILE__)
end

module ExposedTestDSL
  def assert_array
    @posts = JSON.parse response.body
    assert_instance_of Array, @posts

    @post  = @posts.first
  end

  def assert_hash
    @post = JSON.parse response.body
    assert_instance_of Hash, @post
  end

  def assert_attrs
    @keys = @post.keys
    attrs = Post.accessible_attributes.to_a
    diff  = attrs - @keys
    assert_equal 1, diff.length # It's OK if we get more than we need
  end

  def assert_values
    diff = @data.to_a -  @post.to_a
    assert diff.empty?
  end
end