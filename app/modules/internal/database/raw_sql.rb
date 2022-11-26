# frozen_string_literal: true

module Internal
  module Database
    class RawSql
      def initialize(connection)
        @connection = connection
      end

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
    end
  end
end
