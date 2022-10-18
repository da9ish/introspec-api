# frozen_string_literal: true

class Introspec
  class BaseMutation < ::Mutations::BaseMutation
    def self.name
      to_s.gsub("::", "").camelize(:lower)
    end

    def resolve(**kwargs)
      assign_arguments(**kwargs.transform_values { |v| hashify(v) })
      ::ActiveRecord::Base.transaction(requires_new: true) do
        return true if yeild

        raise ::ActiveRecord::Rollback, "Aborting transaction: #{error_message}"
      end
      raise GraphQL::ExecutionError, error_message if errors.present?

      false
    end
  end
end
