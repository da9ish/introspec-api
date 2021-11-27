# frozen_string_literal: true

class User < ApplicationRecord
  include GraphqlDevise::Concerns::Model
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  devise :trackable,
         :recoverable, :rememberable, :omniauthable,
         :database_authenticatable, :registerable,
         :confirmable, :jwt_authenticatable, 
         jwt_revocation_strategy: JwtDenylist
end
