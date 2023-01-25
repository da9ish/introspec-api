# frozen_string_literal: true

class WorkspaceQuery < Introspec::QueryType
  # query ::Authentication::UsersList, authenticate: true

  # query ::Storage::List, authenticate: true
  # query ::Storage::Get, authenticate: true
  # query ::Storage::Upload, authenticate: true
  # query ::Storage::Delete, authenticate: true

  WorkspaceQuery.class_eval do
    # TODO: move this logic inside generate_schema
    database = ::Datum::Database.where(environment_id: ::Environment.first.id).first
    database.tables.map do |table|
      generate_schema = ::Introspec::GenerateSchema.new(table[:id])
      generate_schema.generate_types
      query_classes = generate_schema.generate_queries
      query_classes.each do |query_class|
        query(query_class, authenticate: false)
      end
    end
  end
end
