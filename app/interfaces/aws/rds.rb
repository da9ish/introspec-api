# frozen_string_literal: true

module AWS
  class RDS
    # credentials -> https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Credentials.html
    # region -> string
    def initialize(region_name, credentials, identifier)
      @identifier = identifier
      @client = Aws::RDS::Client.new(
        region:      region_name,
        credentials: credentials
      )
    end

    # https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/Client.html#create_db_instance-instance_method
    def create_db(identifier, username, password)
      @client.create_db_instance({
                                   allocated_storage:      5,
                                   db_instance_class:      "db.t2.micro",
                                   db_instance_identifier: identifier,
                                   engine:                 "PostgreSQL",
                                   master_username:        username,
                                   master_user_password:   password
                                 })
      # on successfull creation, store the credentials for this db in our database
    end

    def modify_db(storage, immediate, instance_class, password, backup_window, maintenance_window)
      @client.modify_db_instance({
                                   allocated_storage:            storage,
                                   apply_immediately:            immediate,
                                   backup_retention_period:      1,
                                   db_instance_class:            instance_class,
                                   db_instance_identifier:       @identifier,
                                   master_user_password:         password,
                                   preferred_backup_window:      backup_window,
                                   preferred_maintenance_window: maintenance_window
                                 })
    end

    def start_db
      @client.start_db_instance({
                                  db_instance_identifier: @identifier
                                })
    end

    def stop_db
      @client.stop_db_instance({
                                 db_instance_identifier: @identifier
                               })
    end

    def reboot_db
      @client.reboot_db_instance({
                                   db_instance_identifier: @identifier,
                                   force_failover:         false
                                 })
    end

    def delete_db
      client.delete_db_instance({
                                  db_instance_identifier: @identifier,
                                  skip_final_snapshot:    true
                                })
    end
  end
end
