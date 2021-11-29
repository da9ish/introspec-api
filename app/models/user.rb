# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  
  devise :recoverable, :omniauthable,
    :database_authenticatable, :registerable

  include GraphqlDevise::Concerns::Model
  include DeviseTokenAuth::Concerns::User
end