# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models

  devise :recoverable, :omniauthable,
         :database_authenticatable, :registerable

  def self.introspec_bot
    @introspec_bot ||= readonly.find_by(username: "introspec_bot")
  end

  include GraphqlDevise::Model
  include DeviseTokenAuth::Concerns::User
end
