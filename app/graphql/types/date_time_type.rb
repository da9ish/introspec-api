# frozen_string_literal: true

module Types
  class DateTimeType < Types::BaseScalar
    def self.coerce_input(value, _ctx)
      return Time.zone.parse(value) if value.present?

      nil
    end

    def self.coerce_result(value, _ctx)
      return nil if value.blank?

      Time.zone.parse(value.to_s).strftime("%Y/%m/%d, %H:%M:%S")
    end
  end
end
