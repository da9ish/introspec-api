# frozen_string_literal: true

module Storage
  class Configuration
    # get current workspace config for storage and initialize s3 interface

    attr_reader :storage

    def initialize
      @storage = nil
      if bucket_exist?
        @storage = ::AWS::S3.new(instance.region,
                                 instance.identifier,
                                 access_key_id:     ENV["AWS_ACCESS_KEY"],
                                 secret_access_key: ENV["AWS_SECRET_KEY"])
      else
        "error: Please create a bucket"
      end
    end

    def create_storage(region_name, bucket_name)
      create_bucket(bucket_name)

      ::Storage::Instance.new(region: region_name, identifier: bucket_name)
    end

    private

    def create_bucket(bucket_name)
      storage.create_bucket(bucket_name)
    end

    def bucket_exist?
      instance.exist?
    end

    def instance
      @instance ||= ::Storage::Instance.find_by_workspace_id(workspace_id: Current.workspace.id)
    end
  end
end
