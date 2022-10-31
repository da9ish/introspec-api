# frozen_string_literal: true

class Subdomain
  STATIC_SUB_DOMAINS = %w[app].freeze

  def initialize
    generate_host
  end

  def generate_host
    dynamic_domains = Workspace.all.map(&:identifier)

    @hosts = dynamic_domains + STATIC_SUB_DOMAINS
  end

  def matches?(request)
    request.subdomain.present? && request.subdomain != "www" && @hosts.include?(request.subdomain)
  end
end
