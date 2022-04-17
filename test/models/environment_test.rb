# frozen_string_literal: true

require "test_helper"

class EnvironmentTest < ActiveSupport::TestCase
  %i[introspec_live].each do |env|
    test "environments(:#{env}) is valid" do
      model = environments(env)
      assert model.valid?, "Expected environments(:#{env}) to be valid, got errors: #{model.errors.full_messages.to_sentence}"
    end
  end
end
