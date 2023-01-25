# frozen_string_literal: true

class ApplicationMutation < Introspec::MutationType
  publish ::CreateColumn
  publish ::CreateTable
  publish ::UpdateColumn
  publish ::UpdateTable

  publish ::Storage::CreateFolder
  publish ::Storage::UpdateFolder

  publish ::Onboard::CreateWorkspace
  publish ::Onboard::CreateEnvironments
end
