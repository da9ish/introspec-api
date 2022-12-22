class CreateWorkspaceJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) do |exception|
    Rails.logger.error(exception.message)
  end

  def perform(workspace_identifier)
    workspace = Workspace.find_by_identifier(workspace_identifier)
    db_client = ::AWS::Database.new("ap-south-1", workspace[:identifier])

    username = "#{workspace[:identifier]}_api_live"
    password = "#{workspace[:identifier]}_api_live"

    response = db_client.create_db(username, username, password).db_instance

    name = "#{workspace[:name]} Database"
    identifier = "#{workspace[:identifier]}-db-instance"
    encrypted_password = BCrypt::Password.create(password)
    allocated_storage = response[:allocated_storage]
    db_instance_class = response[:db_instance_class]
    db_instance_identifier = response[:db_instance_identifier]
    engine = response[:engine]
    db_name = response[:db_name]
    status = response[:db_instance_status]
    host = response[:endpoint]

    database = ::Datum::Database.create!(name: "#{workspace[:name]} API", identifier: "#{workspace[:identifier]}-api", environment: workspace.environments.last)

    ::Datum::Configuration.create!(
      name:                   name,
      identifier:             identifier,
      username:               username,
      encrypted_password:     encrypted_password,
      host:                   host,
      port:                   "5432",
      raw_response:           response,
      allocated_storage:      allocated_storage,
      db_instance_class:      db_instance_class,
      db_instance_identifier: db_instance_identifier,
      engine:                 engine,
      db_name:                db_name,
      status:                 status,
      database:               database
    )
  end
end
