# frozen_string_literal: true

module Identifiable
  extend ActiveSupport::Concern

  included do
    validates :identifier, :name, presence: true
  end
end
