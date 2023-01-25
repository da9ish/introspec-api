# frozen_string_literal: true

module Types
  class DataTypeEnum < ::Types::BaseEnum
    value "int2"
    value "int4"
    value "int8"
    value "float4"
    value "float8"
    value "numeric"
    value "json"
    value "jsonb"
    value "text"
    value "varchar"
    value "uuid"
    value "date"
    value "time"
    value "timetz"
    value "timestamp"
    value "timestamptz"
    value "bool"
  end
end
