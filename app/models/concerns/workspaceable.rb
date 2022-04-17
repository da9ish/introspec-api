# frozen_string_literal: true

module Workspaceable
  extend ActiveSupport::Concern

  ENVIRONMENTS = %w[production staging develop].freeze

  included do
    validates :workspace, :enviroment, presence: true
    validates :enviroment, inclusion: { in: ENVIRONMENTS, message: "'%{value}' is not one of #{ENVIRONMENTS.to_sentence}" }

    default_scope { where(workspace: Current.workspace, enviroment: Current.env) }
  end
end
