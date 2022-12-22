# frozen_string_literal: true

def say(msg)
  Rails.logger.info ">>> #{msg}"
  send(:puts, msg)
end

USERS = [
  { uid: SecureRandom.uuid, username: "introspec_bot", email: "bot@introspec.app", role: "BOT", password: "Q8FUj76mYppUGg69", first_name: "Introspec", last_name: "Bot" },
  { uid: SecureRandom.uuid, username: "da9ish", email: "danish@introspec.app", role: "WORKSPACE_OWNER", password: "1234512345", first_name: "Danish", last_name: "Shah" }
].freeze

WORKSPACES = [{ identifier: "introspec", name: "Introspec", public_api_key: SecureRandom.uuid }].freeze
ENVIRONMENTS = [
  { identifier: "develop", name: "Develop" },
  { identifier: "staging", name: "Staging" },
  { identifier: "live", name: "Live" }
].freeze
DATABASES = [
  { identifier: "introspec-api", name: "Introspec API" }
].freeze
TABLES = [
  { identifier: "account", name: "Account" },
  { identifier: "product", name: "Product" }
].freeze
COLUMNS = {
  account: [
    { identifier: "id", name: "Id", data_type: "UUID", is_indexed: true, constraints: [] },
    { identifier: "name", name: "Name", data_type: "VARCHAR", is_indexed: false, constraints: [] },
    { identifier: "email", name: "Email", data_type: "VARCHAR", is_indexed: false, constraints: [] }
  ],
  product: [
    { identifier: "id", name: "Id", data_type: "UUID", is_indexed: true, constraints: [] },
    { identifier: "sku", name: "SKU", data_type: "VARCHAR", is_indexed: true, constraints: [] }
  ]
}.freeze

WORKSPACES.each do |ws|
  pre_existing = Workspace.exists?(identifier: ws[:identifier])
  say "\nSeed workspace: #{ws[:identifier]}"
  Workspace.create!(ws) unless pre_existing
  say "  * Workspace #{ws[:identifier]} #{pre_existing ? 'found' : 'created'}."

  workspace = Workspace.find_by(identifier: ws[:identifier])

  USERS.each do |user|
    pre_existing = User.exists?(username: user[:username])
    say "\nSeed user: #{user[:username]} in workspace #{ws[:identifier]}"
    User.create!(workspace: workspace, **user.slice(:username, :role, :password, :email, :first_name, :last_name).merge(password_confirmation: user[:password])) unless pre_existing
    say "  * User #{user[:username]} #{pre_existing ? 'found' : 'created'}."
  end

  ENVIRONMENTS.each do |env|
    pre_existing = Environment.exists?(identifier: env[:identifier])
    say "\nSeed environment: #{env[:identifier]} in workspace #{ws[:identifier]}"
    Environment.create!(workspace: workspace, **env) unless pre_existing
    say "  * Environment #{env[:identifier]} #{pre_existing ? 'found' : 'created'} in workspace #{ws[:identifier]}."
  end
end

ENVIRONMENTS.each do |env|
  environment = Environment.find_by(identifier: env[:identifier])
  DATABASES.each do |db|
    pre_existing = ::Datum::Database.exists?(identifier: db[:identifier])
    say "\nSeed database: #{db[:identifier]} in env #{env[:identifier]}"
    ::Datum::Database.create!(environment: environment, **db) unless pre_existing
    say "  * Database #{db[:identifier]} #{pre_existing ? 'found' : 'created'} in env #{env[:identifier]}."
  end
end

DATABASES.each do |db|
  database = ::Datum::Database.find_by(identifier: db[:identifier])
  TABLES.each do |table|
    pre_existing = ::Datum::Table.exists?(identifier: table[:identifier])
    say "\nSeed table: #{table[:identifier]} in db #{db[:identifier]}"
    ::Datum::Table.create!(database: database, **table) unless pre_existing
    say "  * Table #{table[:identifier]} #{pre_existing ? 'found' : 'created'} in database #{db[:identifier]}."
  end
end

COLUMNS.each_key do |tb|
  table = ::Datum::Table.find_by(identifier: tb.to_s)
  COLUMNS[tb].each do |col|
    pre_existing = ::Datum::Column.exists?(identifier: col[:identifier])
    say "\nSeed column: #{col[:identifier]}"
    ::Datum::Column.create!(table: table, **col) unless pre_existing
    say "  * Column #{col[:identifier]} #{pre_existing ? 'found' : 'created'} in table #{tb}.."
  end
end
