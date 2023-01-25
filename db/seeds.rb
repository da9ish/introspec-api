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
DATABASE_CONFIGURATIONS = [
  {
    identifier:             "introspec-api-database",
    name:                   "Introspec API Database",
    username:               "introspec_api_staging",
    encrypted_password:     "PwyCL2DV6KMqag3sQ4LyDwX6eJ3Ggyzu",
    host:                   "dpg-cf4k4rpa6gdtfg351c20-a.frankfurt-postgres.render.com",
    port:                   "5432",
    allocated_storage:      5,
    db_instance_class:      "Postgres",
    db_instance_identifier: "postgres",
    engine:                 "postgres",
    db_name:                "introspec_api_staging",
    status:                 "available",
    raw_response:           {
      username:               "introspec_api_staging",
      encrypted_password:     "PwyCL2DV6KMqag3sQ4LyDwX6eJ3Ggyzu",
      host:                   "dpg-cf4k4rpa6gdtfg351c20-a.frankfurt-postgres.render.com",
      port:                   "5432",
      allocated_storage:      5,
      db_instance_class:      "Postgres",
      db_instance_identifier: "postgres",
      engine:                 "postgres",
      db_name:                "introspec_api_staging",
      status:                 "available"
    }
  }
].freeze
TABLES = [
  { identifier: "account", name: "Account" },
  { identifier: "product", name: "Product" }
].freeze
COLUMNS = {
  account: [
    { identifier: "id", name: "Id", data_type: "uuid", is_indexed: true, is_primary: true, is_unique: true },
    { identifier: "name", name: "Name", data_type: "varchar" },
    { identifier: "email", name: "Email", data_type: "varchar" }
  ],
  product: [
    { identifier: "id", name: "Id", data_type: "uuid", is_indexed: true, is_primary: true, is_unique: true },
    { identifier: "sku", name: "SKU", data_type: "varchar", is_indexed: true }
  ]
}.freeze

BUCKETS = [
  { identifier: "introspec", name: "Introspec" }
].freeze
STORAGE_CONFIGURATIONS = [
  {
    identifier:   "introspec-api-storage",
    name:         "Introspec API Storage",
    location:     nil,
    raw_response: {}
  }
].freeze
FOLDERS = [
  { identifier: "assets", name: "Assets", relative_path: "introspec/assets" }
].freeze
SUB_FOLDERS = [
  { identifier: "images", name: "Images", relative_path: "introspec/assets/images" }
].freeze
FILES = {
  images: [
    { identifier: "image-1", name: "Image 1", file_type: "image", size: 24_100, relative_path: "introspec/assets/images" }
  ],
  assets: [
    { identifier: "image-2", name: "Image 2", file_type: "image", size: 24_100, relative_path: "introspec/assets" }
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
    pre_existing = Datum::Database.exists?(identifier: db[:identifier])
    say "\nSeed database: #{db[:identifier]} in env #{env[:identifier]}"
    Datum::Database.create!(environment: environment, **db) unless pre_existing
    say "  * Database #{db[:identifier]} #{pre_existing ? 'found' : 'created'} in env #{env[:identifier]}."
  end

  BUCKETS.each do |bucket|
    pre_existing = CloudStore::Bucket.exists?(identifier: bucket[:identifier])
    say "\nSeed bucket: #{bucket[:identifier]} in env #{env[:identifier]}"
    CloudStore::Bucket.create!(environment: environment, **bucket) unless pre_existing
    say "  * Bucket #{bucket[:identifier]} #{pre_existing ? 'found' : 'created'} in env #{env[:identifier]}."
  end
end

DATABASES.each do |db|
  database = Datum::Database.find_by(identifier: db[:identifier])

  DATABASE_CONFIGURATIONS.each do |config|
    pre_existing = DatabaseConfiguration.exists?(identifier: config[:identifier])
    say "\nSeed configuration: #{config[:identifier]} in db #{db[:identifier]}"
    DatabaseConfiguration.create!(database: database, **config) unless pre_existing
    say "  * Configuration #{config[:identifier]} #{pre_existing ? 'found' : 'created'} in database #{db[:identifier]}."
  end

  TABLES.each do |table|
    pre_existing = Datum::Table.exists?(identifier: table[:identifier])
    say "\nSeed table: #{table[:identifier]} in db #{db[:identifier]}"
    Datum::Table.create!(database: database, **table) unless pre_existing
    say "  * Table #{table[:identifier]} #{pre_existing ? 'found' : 'created'} in database #{db[:identifier]}."
  end
end

COLUMNS.each_key do |tb|
  table = Datum::Table.find_by(identifier: tb.to_s)
  COLUMNS[tb].each do |col|
    pre_existing = Datum::Column.exists?(identifier: col[:identifier])
    say "\nSeed column: #{col[:identifier]}"
    Datum::Column.create!(table: table, **col) unless pre_existing
    say "  * Column #{col[:identifier]} #{pre_existing ? 'found' : 'created'} in table #{tb}."
  end
end

BUCKETS.each do |bk|
  bucket = CloudStore::Bucket.find_by(identifier: bk[:identifier])

  STORAGE_CONFIGURATIONS.each do |config|
    pre_existing = StorageConfiguration.exists?(identifier: config[:identifier])
    say "\nSeed configuration: #{config[:identifier]} in bucket #{bk[:identifier]}"
    StorageConfiguration.create!(bucket: bucket, **config) unless pre_existing
    say "  * Configuration #{config[:identifier]} #{pre_existing ? 'found' : 'created'} in bucket #{bk[:identifier]}."
  end

  FOLDERS.each do |folder|
    pre_existing = CloudStore::Folder.exists?(identifier: folder[:identifier])
    say "\nSeed folder: #{folder[:identifier]} in bucket #{bucket[:identifier]}"
    CloudStore::Folder.create!(bucket: bucket, **folder) unless pre_existing
    say "  * Folder #{folder[:identifier]} #{pre_existing ? 'found' : 'created'} in bucket #{bk[:identifier]}."

    folder = CloudStore::Folder.find_by(identifier: folder[:identifier])

    SUB_FOLDERS.each do |sub_fldr|
      pre_existing = CloudStore::Folder.exists?(identifier: sub_fldr[:identifier])
      say "\nSeed folder: #{sub_fldr[:identifier]} in folder #{folder[:identifier]}"
      CloudStore::Folder.create!(bucket: bucket, folder_id: folder[:id], **sub_fldr) unless pre_existing

      say "  * Folder #{sub_fldr[:identifier]} #{pre_existing ? 'found' : 'created'} in folder #{sub_fldr[:identifier]}."
    end
  end

  FILES.each_key do |fldr|
    folder = CloudStore::Folder.find_by(identifier: fldr.to_s)
    FILES[fldr].each do |file|
      pre_existing = CloudStore::File.exists?(identifier: file[:identifier])
      say "\nSeed file: #{file[:identifier]}"
      CloudStore::File.create!(bucket: bucket, folder: folder, **file) unless pre_existing
      say "  * File #{file[:identifier]} #{pre_existing ? 'found' : 'created'} in folder #{fldr}."
    end
  end
end
