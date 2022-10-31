# frozen_string_literal: true

class WorkspaceQuery < ::Introspec::QueryType
  # query ::Authentication::UsersList, authenticate: true

  WorkspaceQuery.class_eval do
    ::Table.all.map do |table|
      generate_schema = ::Introspec::GenerateSchema.new(table: table)
      query_classes = generate_schema.generate_queries
      query_classes.each do |query_class|
        query(query_class, authenticate: true)
      end
    end
  end
end
