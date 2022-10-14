# frozen_string_literal: true

# Valid query `auth` types:
# public, internal, external
# default -> internal

class ApplicationQuery < ::Introspec::QueryType
  query ::CurrentAccount, authenticate: false
  query ::Schema, authenticate: true
  # test
  # query ::TestField, auth: :public
  # query ::TestFieldWithArgs, auth: :public
  # query ::TestFieldWithArgsAndSelector, auth: :public
end
