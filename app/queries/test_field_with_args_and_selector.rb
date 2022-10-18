# frozen_string_literal: true

class TestFieldWithArgsAndSelector < ::Introspec::BaseQuery
  type Types::TestType, null: false

  argument :test_param, String, required: true

  def resolve(test_param:)
    {
      status:     200,
      message:    "Success",
      test_param: test_param
    }
  end
end
