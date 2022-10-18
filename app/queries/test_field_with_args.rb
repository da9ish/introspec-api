# frozen_string_literal: true

class TestFieldWithArgs < ::Introspec::BaseQuery
  type String, null: false

  argument :test_param, String, required: true

  def resolve(test_param:)
    test_param
  end
end
