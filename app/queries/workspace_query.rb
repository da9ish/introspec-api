# frozen_string_literal: true

class WorkspaceQuery < ::Introspec::QueryType
  query ::UsersList, authenticate: true
end
