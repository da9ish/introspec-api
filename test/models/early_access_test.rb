# frozen_string_literal: true

require "test_helper"

class EarlyAccessTest < ActiveSupport::TestCase
  %i[test].each do |email|
    test "early_accesses(:#{email}) is valid" do
      model = early_accesses(email)
      assert model.valid?, "Expected early_accesses(:#{email}) to be valid, got errors: #{model.errors.full_messages.to_sentence}"
    end
  end
end
