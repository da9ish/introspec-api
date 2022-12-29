# frozen_string_literal: true

module AWS
  class Storage
    # credentials -> https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Credentials.html
    # region -> string

    def initialize(region_name, identifier)
      @identifier = identifier || ""
      @region_name = region_name || ""
      @client = Aws::S3::Client.new(
        region:            region_name,
        access_key_id:     ENV["AWS_ACCESS_KEY"],
        secret_access_key: ENV["AWS_SECRET_KEY"]
      )
    end

    def create_bucket
      @client.create_bucket({
                              bucket:                         @identifier,
                              acl:                            "public-read-write",
                              create_bucket_configuration:    {
                                location_constraint: @region_name
                              },
                              # grant_full_control:             "GrantFullControl",
                              # grant_read:                     "GrantRead",
                              # grant_read_acp:                 "GrantReadACP",
                              # grant_write:                    "GrantWrite",
                              # grant_write_acp:                "GrantWriteACP",
                              object_lock_enabled_for_bucket: false
                              # object_ownership:               "BucketOwnerEnforced"
                            })
      # store response of create bucket into db
      # set identifier in parent class
    end

    def delete_bucket
      @client.delete_bucket({
                              bucket: @identifier
                            })
    end

    def delete_file(file_name)
      @client.delete_object({
                              bucket: @identifier,
                              key:    file_name
                            })
    end

    def get_file(file_name)
      @client.get_object({
                           bucket: @identifier,
                           key:    file_name
                         })
    end

    def list_files
      # figure out pagination here
      @client.list_objects({
                             bucket: @identifier
                           })
    end

    # tags = "key1=value1&key2=value2"
    def put_file(body, file_name, tags)
      @client.put_object({
                           body:    body,
                           bucket:  @identifier,
                           key:     file_name,
                           tagging: tags
                         })
    end
  end
end
