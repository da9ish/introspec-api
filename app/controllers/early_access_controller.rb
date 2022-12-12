# frozen_string_literal: true

class EarlyAccessController < ApplicationController
  def create
    pre_existing = EarlyAccess.exists?(email: create_params[:email])
    early_access = EarlyAccess.new(email: create_params[:email])

    if pre_existing
      render json: { errors: [{ message: "Already invited" }], status: "409" }, status: :ok
    elsif early_access.save
      render json: { data: { message: "You've be added to the list!" }, status: "200" }, status: :ok
    else
      render json: { errors: [{ message: early_access.errors.full_messages.to_sentence }], data: {}, status: "422" }, status: :ok
    end
  end

  private

  def create_params
    params.permit(:email)
  end
end
