# frozen_string_literal: true

class ApplicationQuery < Introspec::QueryType
  query ::CurrentAccount, authenticate: false
  query ::CurrentWorkspace, authenticate: true
  query ::UsersList, authenticate: true

  query ::Database::Schema, authenticate: true
  query ::Storage::Directory, authenticate: true

  # test
  query ::TestField, authenticate: false
  query ::TestFieldWithArgs, authenticate: false
  query ::TestFieldWithArgsAndSelector, authenticate: false
end
