# frozen_string_literal: true

class User < ApplicationRecord
  devise :recoverable, :omniauthable,
    :database_authenticatable, :registerable

  include GraphqlDevise::Authenticatable

  devise :recoverable, :omniauthable,
         :database_authenticatable, :registerable
  
  def self.introspec_bot
    @introspec_bot ||= readonly.find_by(username: "introspec_bot")
  end

end
