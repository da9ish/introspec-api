# frozen_string_literal: true

class ApplicationMutation < ::Introspec::MutationType
  publish ::CreateTable
  publish ::Onboard::CreateWorkspace
  publish ::Onboard::CreateEnvironments
end
