# frozen_string_literal: true

require "subdomain"

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints subdomain: 'api' do
    post "/graphql", to: "graphql#execute"
    post "/early-access", to: "early_access#create"

    post "/:workspace", to: "schema#execute"
  end

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
end
