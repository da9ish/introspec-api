# frozen_string_literal: true

module Introspec
  class GenerateSchema
    SQL_TO_GQL_DATA_TYPE_MAP = {
      int2:        GraphQL::Types::Int,
      int4:        GraphQL::Types::Int,
      int8:        GraphQL::Types::Int,
      float4:      GraphQL::Types::Int,
      float8:      GraphQL::Types::Int,
      numeric:     GraphQL::Types::Int,
      json:        GraphQL::Types::JSON,
      jsonb:       GraphQL::Types::JSON,
      text:        GraphQL::Types::String,
      varchar:     GraphQL::Types::String,
      uuid:        GraphQL::Types::ID,
      date:        GraphQL::Types::String,
      time:        GraphQL::Types::String,
      timetz:      GraphQL::Types::String,
      timestamp:   GraphQL::Types::String,
      timestamptz: GraphQL::Types::String,
      bool:        GraphQL::Types::Boolean
    }.freeze

    def initialize(table_id)
      @@table = ::Datum::Table.find(table_id)
      @@columns = ::Datum::Column.where(table_id: table_id) || []
      # configuration = ::DatabaseConfiguration.where(database_id: @@table.database.id).first
      # @db = ::Database::Connector.new(
      #   configuration.host,
      #   configuration.db_name,
      #   configuration.username,
      #   configuration.username
      # )
    end

    def generate_types
      @@base_type_name = "#{@@table[:name].titleize.remove(' ').classify}Type"

      if Introspec.const_defined?(@@base_type_name)
        @@type_class = Introspec.const_get(@@base_type_name)
        @@columns.map do |col|
          next if @@type_class.all_field_definitions.map(&:graphql_name).map(&:underscore).include?(col.identifier)

          @@type_class.class_eval.send(:field, col.identifier, type: SQL_TO_GQL_DATA_TYPE_MAP[col.data_type.to_sym], null: true)
        end
        return true
      else
        base_type_class = Introspec.const_set(@@base_type_name, Class.new(::Types::BaseObject) do
          class_eval do
            def self.graphql_name
              to_s.split("::").last.gsub("::", "").titleize.remove(" ").classify
            end

            @@columns.map do |col|
              field(col.identifier, type: SQL_TO_GQL_DATA_TYPE_MAP[col.data_type.to_sym], null: true)
            end
          end
        end)
        @@type_class = base_type_class
      end

      @@type_class
    end

    def generate_queries
      list_query_name = "#{@@table[:name].titleize.remove(' ').classify}List"
      Introspec.send(:remove_const, list_query_name) if Introspec.const_defined?(list_query_name)

      list_query_class = Introspec.const_set(list_query_name, Class.new(::Introspec::BaseQuery) do
        class_eval do
          description "List all the #{@@table[:name]}'s"
          def self.graphql_name
            to_s.split("::").last.gsub("::", "").titleize.remove(" ").classify
          end
          type([@@type_class], null: true)
        end

        def resolve
          # get data from database
          @db.list(@@table[:identifier])
        end
      end)

      read_query_name = @@table[:name].titleize.remove(" ").classify.to_s
      Introspec.send(:remove_const, read_query_name) if Introspec.const_defined?(read_query_name)
      read_query_class = Introspec.const_set(read_query_name, Class.new(::Introspec::BaseQuery) do
        class_eval do
          description "Get #{@@table[:name]} by id"
          def self.graphql_name
            to_s.split("::").last.gsub("::", "").titleize.remove(" ").classify
          end
          col = @@columns.first
          argument(col.identifier, type: SQL_TO_GQL_DATA_TYPE_MAP[col.data_type.to_sym], required: true)
          type(@@type_class, null: true)
        end

        def resolve
          # get data from database
          {}
        end
      end)

      [list_query_class, read_query_class]
    end

    # rubocop:disable Metrics/AbcSize
    def generate_mutations
      create_mutation_name = "Create#{@@table[:name].titleize.remove(' ').classify}"
      Introspec.send(:remove_const, create_mutation_name) if Introspec.const_defined?(create_mutation_name)

      create_mutation_class = Introspec.const_set(create_mutation_name, Class.new(::Introspec::BaseMutation) do
        class_eval do
          description "Create #{@@table[:name]} Mutation"
          def self.graphql_name
            to_s.split("::").last.gsub("::", "").titleize.remove(" ").classify
          end
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
      Introspec.send(:remove_const, update_mutation_name) if Introspec.const_defined?(update_mutation_name)

      update_mutation_class = Introspec.const_set(update_mutation_name, Class.new(::Introspec::BaseMutation) do
        class_eval do
          description "Update #{@@table[:name]} Mutation"
          def self.graphql_name
            to_s.split("::").last.gsub("::", "").titleize.remove(" ").classify
          end
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
      Introspec.send(:remove_const, destroy_mutation_name) if Introspec.const_defined?(destroy_mutation_name)

      destroy_mutation_class = Introspec.const_set(destroy_mutation_name, Class.new(::Introspec::BaseMutation) do
        class_eval do
          description "Delete #{@@table[:name]} Mutation"
          def self.graphql_name
            to_s.split("::").last.gsub("::", "").titleize.remove(" ").classify
          end
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

    # rubocop:enable Metrics/AbcSize

    # def table
    #   @@table ||= ::Datum::Table.find(@table_id)
    # end

    # def columns
    #   @@columns ||= ::Datum::Column.where(table_id: @table_id)
    # end
  end
end
