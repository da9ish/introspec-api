# frozen_string_literal: true

module Types
  class DataTypeEnum < ::Types::BaseEnum
    value "BOOLEAN"
    value "CHAR"
    value "VARCHAR"
    value "TEXT"
    value "NUMERIC"
    value "INTEGER"
    value "SERIAL"
    value "DATE"
    value "TIMESTAMP"
    value "INTERVAL"
    value "TIME"
    value "UUID"
    value "JSON"
    value "ARRAY"
  end
end
