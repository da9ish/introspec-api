# frozen_string_literal: true

module Database
  class RawSql
    ACTIVE_RECORD_DATA_TYPE_MAP = {
      int2:        :integer,
      int4:        :integer,
      int8:        :bigint,
      float4:      :float,
      float8:      :decimal,
      numeric:     :numeric,
      json:        :json,
      jsonb:       :json,
      text:        :text,
      varchar:     :string,
      uuid:        :bigint,
      date:        :date,
      time:        :time,
      timetz:      :time,
      timestamp:   :time,
      timestamptz: :time,
      bool:        :boolean
    }.freeze

    def initialize(host, database, username, password)
      # TODO: get configuration and establish connection
      ActiveRecord::Base.establish_connection(
        adapter:  "postgresql",
        host:     host,
        port:     5432,
        database: database,
        username: username,
        password: password
      )
      @connection = ActiveRecord::Base.connection
    end

    # https://apidock.com/rails/v5.2.3/ActiveRecord/ConnectionAdapters/SchemaStatements/create_table
    def create_table(name, columns)
      @connection.create_table(name.to_sym)
      columns.map do |col|
        @connection.add_column(
          name.to_sym,
          col.identifier,
          col.is_primary ? ACTIVE_RECORD_DATA_TYPE_MAP[col.data_type] : :primary,
          {
            default: col.default_value,
            null:    col.is_nullable,
            array:   col.is_array
          }
        )
        next unless col.is_indexed

        @connection.add_index(
          name.to_sym,
          col.identifier,
          {
            unique: col.is_unique
          }
        )
      end
    end

    # def add_column(name, columns)

    def list_tables
      `
      SELECT table_name
        FROM information_schema.tables
      WHERE table_type = 'BASE TABLE'
        AND table_schema NOT IN
            ('pg_catalog', 'information_schema');
      `
    end

    def list_columns_for_table(table_name)
      `
      SELECT
        a.table_name,
        a.ordinal_position,
        a.column_name,
        a.data_type,
        a.column_default,
        a.is_nullable,
        a.character_maximum_length,
        a.numeric_precision,
        c.constraint_name,
        c.constraint_type
      FROM information_schema.columns a
      LEFT JOIN information_schema.constraint_column_usage b
        ON a.column_name = b.column_name
      LEFT JOIN information_schema.table_constraints c
        ON b.constraint_name = c.constraint_name
      WHERE table_name = '#{table_name}'
      ORDER BY ordinal_position;
      `
    end

    # rubocop:disable Metrics/MethodLength
    def list_indices_for_table(table_name)
      `
      SELECT
          t.relname AS table_name,
          i.relname AS index_name,
          a.attname AS column_name
      FROM
          pg_class t,
          pg_class i,
          pg_index ix,
          pg_attribute a
      WHERE
          t.oid = ix.indrelid
          and i.oid = ix.indexrelid
          and a.attrelid = t.oid
          and a.attnum = ANY(ix.indkey)
          and t.relkind = 'r'
          and t.relname = '#{table_name}'
      ORDER BY
          t.relname,
          i.relname;
      `
    end
    # rubocop:enable Metrics/MethodLength
  end
end
