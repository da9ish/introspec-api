# frozen_string_literal: true

class WorkspaceQuery < Introspec::QueryType
  def test
    "Test"
  end
  # query ::Authentication::UsersList, authenticate: true

  # query ::Storage::List, authenticate: true
  # query ::Storage::Get, authenticate: true
  # query ::Storage::Upload, authenticate: true
  # query ::Storage::Delete, authenticate: true

  WorkspaceQuery.class_eval do
    database = ::Datum::Database.where(environment_id: context[:environment_id]).first
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
