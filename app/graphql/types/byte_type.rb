# frozen_string_literal: true

module Types
  class ByteType < Types::BaseScalar
    def self.coerce_result(value, _ctx)
      return nil if value.blank?

      units = %w[bytes KB MB GB TB]

      index = (Math.log(value) / Math.log(1024)).floor
      size = value / (1024.0**index)

      "#{size.round(2)} #{units[index]}"
    end
  end
end
