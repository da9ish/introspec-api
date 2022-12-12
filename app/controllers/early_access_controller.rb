# frozen_string_literal: true

class EarlyAccessController < ApplicationController
  def create
    pre_existing = EarlyAccess.exists?(email: params[:email])
    early_access = EarlyAccess.new(email: params[:email])

    if pre_existing
      render json: { data: { message: "Already exists" }, status: :conflict }, status: :conflict
    elsif early_access.save
      render json: { data: { message: "You've be added to the list!" }, status: :ok }, status: :ok
    else
      render json: { errors: [{ message: early_access.errors.full_messages.to_sentence }], data: {} }, status: :internal_server_error
    end
  end
end
