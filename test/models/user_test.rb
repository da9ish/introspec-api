# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  %i[introspec_bot].each do |username|
    test "users(:#{username}) is valid" do
      model = users(username)
      assert model.valid?, "Expected users(:#{username}) to be valid, got errors: #{model.errors.full_messages.to_sentence}"
    end
  end
end