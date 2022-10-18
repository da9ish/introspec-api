# frozen_string_literal: true

class Introspec
  module GraphqlTestHelper
    def query(field, input: nil, selector: nil)
      operation_name = field.to_s.camelize(:lower)
      %(
        query #{operation_name} #{input.present? ? "(#{input.map { |k, v| "$#{k}:#{v}" }.join(', ')})" : ''} {
          #{operation_name} #{input.present? ? "(#{input.map { |k, _v| "#{k}:$#{k}" }.join(', ')})" : ''}
            #{selector.presence ? "{#{selector}}" : ''}
        }
      )
    end

    def mutation(field, input:, selector:)
      operation_name = field.to_s.camelize(:lower)

      %(
        mutation #{operation_name}($input: #{input}) {
          #{operation_name}(input: $input)
            {#{selector.presence || ''}}
          }
      )
    end

    def execute(operation, variables, file: nil, files_hash: nil)
      ::IntrospecApiSchema.execute(operation, context: { current_resource: Current.user, file: file, files_hash: files_hash }, variables: variables&.deep_transform_keys! { |key| key.to_s.camelize(:lower) })
    end
  end
end
