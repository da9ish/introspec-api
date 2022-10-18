# frozen_string_literal: true

class User < ApplicationRecord
  devise :recoverable, :omniauthable,
         :database_authenticatable, :registerable

  include GraphqlDevise::Authenticatable

  devise :recoverable, :omniauthable,
         :database_authenticatable, :registerable

  belongs_to :workspace, class_name: "::Workspace", primary_key: "identifier", inverse_of: :users, optional: true

  def self.introspec_bot
    @introspec_bot ||= readonly.find_by(username: "introspec_bot")
  end
end
