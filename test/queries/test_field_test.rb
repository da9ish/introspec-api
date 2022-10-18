# frozen_string_literal: true

require "test_helper"

class TestFieldTest < ::ActiveSupport::TestCase
  include Introspec::GraphqlTestHelper

  test "test_field query" do
    Current.test do
      query = query(:test_field, input: nil, selector: nil)
      result = execute(query, nil)

      assert result["errors"].nil?, "Test field query failed. ERR: #{result['errors']}"
      assert result["data"], "Hello World!"
    end
  end
end
