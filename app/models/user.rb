# frozen_string_literal: true

class User < ApplicationRecord
  devise :recoverable, :omniauthable,
         :database_authenticatable, :registerable

  include GraphqlDevise::Authenticatable

  devise :recoverable, :omniauthable,
         :database_authenticatable, :registerable

  ROLES = %w[WORKSPACE_OWNER WORKSPACE_MEMBER WORKSPACE_USER BOT].freeze

  belongs_to :workspace, class_name: "::Workspace", primary_key: "id", inverse_of: :users, optional: true

  validates :role, inclusion: { in: ROLES, message: "'%{value}' is not one of #{ROLES.to_sentence}" }

  def owner?
    role == "WORKSPACE_OWNER"
  end

  def member?
    role == "WORKSPACE_MEMBER"
  end

  def user?
    role == "WORKSPACE_USER"
  end

  def self.introspec_bot
    @introspec_bot ||= readonly.find_by(username: "introspec_bot")
  end
end
