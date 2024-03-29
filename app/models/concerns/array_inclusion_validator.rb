# frozen_string_literal: true

class ArrayInclusionValidator < ActiveModel::EachValidator
  include ActiveModel::Validations::Clusivity

  def validate_each(record, attribute, values)
    values.each do |value|
      unless include?(record, value)
        message = (options[:message].try(:gsub, "%{value}", value) || "#{value} is not included in the list")
        record.errors.add(attribute, :array_inclusion, message: message, value: value)
      end
    end
  end
end
