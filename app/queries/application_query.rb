# frozen_string_literal: true

class ApplicationQuery < ::Introspec::QueryType
  query ::CurrentAccount, authenticate: false
  query ::Schema, authenticate: true
  query ::UsersList, authenticate: true

  # test
  query ::TestField, authenticate: false
  query ::TestFieldWithArgs, authenticate: false
  query ::TestFieldWithArgsAndSelector, authenticate: false
end
