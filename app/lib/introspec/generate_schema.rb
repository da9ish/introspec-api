# frozen_string_literal: true

module Introspec
  class GenerateSchema
    SQL_TO_GQL_DATA_TYPE_MAP = {
      UUID:      GraphQL::Types::ID,
      BOOLEAN:   GraphQL::Types::Boolean,
      CHAR:      GraphQL::Types::String,
      VARCHAR:   GraphQL::Types::String,
      TEXT:      GraphQL::Types::String,
      NUMERIC:   GraphQL::Types::Int,
      INTEGER:   GraphQL::Types::Int,
      SERIAL:    GraphQL::Types::String,
      DATE:      GraphQL::Types::String,
      TIMESTAMP: GraphQL::Types::String,
      INTERVAL:  GraphQL::Types::String,
      TIME:      GraphQL::Types::String,
      JSON:      GraphQL::Types::JSON,
      ARRAY:     GraphQL::Types::String
    }.freeze

    def initialize(table_id)
      @@table = ::Datum::Table.find(table_id)
      @@columns = ::Datum::Column.where(table_id: table_id) || []
      configuration = ::Datum::Configuration.where(database_id: @@table.database.id).first
      # @db = ::Internal::Database::DB.new(
      #   configuration.host,
      #   configuration.db_name,
      #   configuration.username,
      #   configuration.username
      # )
    end

    def generate_types
      base_type_name = "#{@@table[:name].titleize.remove(' ').classify}Type"
      # Object.send(:remove_const, base_type_name) if Object.const_defined?(base_type_name)
      if Object.const_defined?(base_type_name)
        @@type_class = Object.const_get(base_type_name)
        @@columns.map do |col|
          next if @@type_class.all_field_definitions.map(&:graphql_name).map(&:underscore).include?(col.identifier)
          @@type_class.send(:field, col.identifier, type: SQL_TO_GQL_DATA_TYPE_MAP[col.data_type.to_sym], null: true)
        end
        return true
      end

      base_type_class = Object.const_set(base_type_name, Class.new(::Types::BaseObject) do
        class_eval do
          @@columns.map do |col|
            field(col.identifier, type: SQL_TO_GQL_DATA_TYPE_MAP[col.data_type.to_sym], null: true)
          end
        end
      end)

      @@type_class = base_type_class
    end

    def generate_queries
      list_query_name = "#{@@table[:name].titleize.remove(' ').classify}List"
      Object.send(:remove_const, list_query_name) if Object.const_defined?(list_query_name)

      list_query_class = Object.const_set(list_query_name, Class.new(::Introspec::BaseQuery) do
        class_eval do
          type([@@type_class], null: true)
        end

        def resolve
          # get data from database
          @db.list(@@table[:identifier])
        end
      end)

      read_query_name = @@table[:name].titleize.remove(" ").classify.to_s
      Object.send(:remove_const, read_query_name) if Object.const_defined?(read_query_name)
      read_query_class = Object.const_set(read_query_name, Class.new(::Introspec::BaseQuery) do
        class_eval do
          type(@@type_class, null: true)
        end

        def resolve
          # get data from database
          {}
        end
      end)

      [list_query_class, read_query_class]
    end

    def generate_mutations
      create_mutation_name = "Create#{@@table[:name].titleize.remove(' ').classify}"
      Object.send(:remove_const, create_mutation_name) if Object.const_defined?(create_mutation_name)

      create_mutation_class = Object.const_set(create_mutation_name, Class.new(::Introspec::BaseMutation) do
        class_eval do
          @@columns.map do |col|
            argument(col.identifier, type: SQL_TO_GQL_DATA_TYPE_MAP[col.data_type.to_sym], required: true)
          end
          type(@@type_class, null: true)
        end

        def resolve(**_kwargs)
          # create data in database
          {}
        end
      end)

      update_mutation_name = "Update#{@@table[:name].titleize.remove(' ').classify}"
      Object.send(:remove_const, update_mutation_name) if Object.const_defined?(update_mutation_name)

      update_mutation_class = Object.const_set(update_mutation_name, Class.new(::Introspec::BaseMutation) do
        class_eval do
          @@columns.map do |col|
            argument(col.identifier, type: SQL_TO_GQL_DATA_TYPE_MAP[col.data_type.to_sym], required: true)
          end
          type(@@type_class, null: true)
        end

        def resolve(**_kwargs)
          # create data in database
          {}
        end
      end)

      destroy_mutation_name = "Destroy#{@@table[:name].titleize.remove(' ').classify}"
      Object.send(:remove_const, destroy_mutation_name) if Object.const_defined?(destroy_mutation_name)

      destroy_mutation_class = Object.const_set(destroy_mutation_name, Class.new(::Introspec::BaseMutation) do
        class_eval do
          argument(:id, type: GraphQL::Types::ID, required: true)
          type(@@type_class, null: true)
        end

        def resolve(**_kwargs)
          # create data in database
          {}
        end
      end)

      [create_mutation_class, update_mutation_class, destroy_mutation_class]
    end

    # def table
    #   @@table ||= ::Datum::Table.find(@table_id)
    # end

    # def columns
    #   @@columns ||= ::Datum::Column.where(table_id: @table_id)
    # end
  end
end
