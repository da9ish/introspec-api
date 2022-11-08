# frozen_string_literal: true

require "subdomain"

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post "/graphql", to: "graphql#execute"

  post "/graphql", to: "schema#execute", constraints: lambda { |request|
    hosts = Workspace.all.map(&:identifier)
    request.subdomain.present? && request.subdomain != "www" && hosts.include?(request.subdomain)
  }

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
end
