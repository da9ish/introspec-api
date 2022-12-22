# frozen_string_literal: true

module Types
  class ConstraintsEnum < ::Types::BaseEnum
    value "NOT_NULL"
    value "UNIQUE"
    value "PRIMARY"
    value "FOREIGN"
    value "CHECK"
    value "EXCLUSION"
  end
end
