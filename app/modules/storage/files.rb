# frozen_string_literal: true

module Storage
  class Files < Storage::Configuration
    # create and manage config for storage
    # this will be the graphQL queries and mutations
    # decorate for the gql layer

    # for mvp let's ignore folders

    delegate :list_files, to: :storage

    delegate :get_file, to: :storage

    delegate :delete_file, to: :storage

    def upload_file(body, file_name, tags)
      storage.put_file(body, file_name, tags)
    end
  end
end
