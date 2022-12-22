# frozen_string_literal: true

module Internal
  module Database
    class Configuration
      # get current workspace config for database and initialize rds interface

      # transaction
      # migration
      #

      attr_reader :db

      def initialize
        @db = nil
        if db_exist?
          @db = ::AWS::RDS.new(instance.region, credentials, instance.identifier)
        else
          "error: Please create a database"
        end
      end

      def create_db_instance(db_name, _region_name, username, password)
        create_db(db_name, username, password)

        # hash the password before saving
        # ::Database::Instance.new(identifier: db_name, region: region_name, username: username, password: password)
      end

      def execute
        DB.transaction do
          yeild
          raise Sequel::Rollback
        end
      end

      private

      def create_db(db_name, _username, _password)
        db.create_db(db_name)
      end

      def db_exist?
        instance.exist?
      end

      def instance
        @instance ||= ::Database::Instance.where(workspace_id: Current.workspace.id).first
      end
    end
  end
end
