# frozen_string_literal: true

require "test_helper"

module AWS
  class DatabaseTest < ::ActiveSupport::TestCase
    test "create rds instance test" do
      Current.test do
        # rds = Aws::Database.new("ap-south-1", "spacex")
        # resp = rds.create_db("spacex_api", "spacex_api")
        # ap resp.db_instance[:db_instance_status]
        # rds.delete_db
      end
    end
  end
end