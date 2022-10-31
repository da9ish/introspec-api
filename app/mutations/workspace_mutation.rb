# frozen_string_literal: true

class WorkspaceMutation < ::Introspec::MutationType
  WorkspaceMutation.class_eval do
    ::Table.all.map do |table|
      generate_schema = ::Introspec::GenerateSchema.new(table: table)
      mutation_classes = generate_schema.generate_mutations
      mutation_classes.each do |mutation_class|
        publish(mutation_class)
      end
    end
  end
end
