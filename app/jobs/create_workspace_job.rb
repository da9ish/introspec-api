# frozen_string_literal: true

class CreateWorkspaceJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) do |exception|
    Rails.logger.error(exception.message)
  end

  def perform(workspace_identifier)
    workspace = Workspace.find_by(identifier: workspace_identifier)
    bucket_name = "#{workspace[:identifier]}-#{SecureRandom.uuid}"

    # db_client = ::AWS::RdsClient.new("ap-south-1", workspace[:identifier])
    # storage_client = ::AWS::S3Client.new("ap-south-1", bucket_name)

    # username = "#{workspace[:identifier]}_api_live"
    # password = "#{workspace[:identifier]}_api_live"

    # rds_response = db_client.create_db(username, username, password).db_instance
    # s3_response = storage_client.create_bucket.to_h

    # name = "#{workspace[:name]} Database"
    # identifier = "#{workspace[:identifier]}-db-instance"
    # encrypted_password = BCrypt::Password.create(password)
    # allocated_storage = rds_response[:allocated_storage]
    # db_instance_class = rds_response[:db_instance_class]
    # db_instance_identifier = rds_response[:db_instance_identifier]
    # engine = rds_response[:engine]
    # db_name = rds_response[:db_name]
    # status = rds_response[:db_instance_status]
    # host = rds_response[:endpoint]

    # location = s3_response[:location]

    database = ::Datum::Database.create!(name: "#{workspace[:name]} API", identifier: "#{workspace[:identifier]}-api", environment: workspace.environments.last)
    bucket = ::CloudStore::Bucket.create!(name: bucket_name, identifier: workspace[:identifier], environment: workspace.environments.last)

    # ::DatabaseConfiguration.create!(
    #   name:                   name,
    #   identifier:             identifier,
    #   username:               username,
    #   encrypted_password:     encrypted_password,
    #   host:                   host,
    #   port:                   "5432",
    #   raw_response:           rds_response,
    #   allocated_storage:      allocated_storage,
    #   db_instance_class:      db_instance_class,
    #   db_instance_identifier: db_instance_identifier,
    #   engine:                 engine,
    #   db_name:                db_name,
    #   status:                 status,
    #   database:               database
    # )

    # ::StorageConfiguration.create!(
    #   name:         "#{workspace[:name]} Storage",
    #   identifier:   "#{workspace[:identifier]}-storage",
    #   location:     location,
    #   raw_response: s3_response.as_json,
    #   bucket:       bucket
    # )
  end
end
