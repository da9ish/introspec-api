# frozen_string_literal: true

class WorkspaceMutation < Introspec::MutationType
  WorkspaceMutation.class_eval do
    database = ::Datum::Database.where(environment_id: context[:environment_id]).first
    database.tables.map do |table|
      generate_schema = ::Introspec::GenerateSchema.new(table[:id])
      # generate_schema.generate_types
      mutation_classes = generate_schema.generate_mutations
      mutation_classes.each do |mutation_class|
        publish(mutation_class)
      end
    end
  end
end
