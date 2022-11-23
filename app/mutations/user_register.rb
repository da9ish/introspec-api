# frozen_string_literal: true

class UserRegister < GraphqlDevise::Mutations::Register
  def self.name
    to_s.split("::").last.gsub("::", "").camelize(:lower)
  end

  argument :role, ::Types::RoleEnum, required: true
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :username, String, required: true

  field :credentials, GraphqlDevise::Types::CredentialType, null: true
  field :authenticatable, Types::User, null: true
end
