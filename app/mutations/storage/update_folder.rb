# frozen_string_literal: true

module Storage
  class UpdateFolder < ::Introspec::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :identifier, String, required: false
    argument :relative_path, String, required: false

    type ::Types::Storage::Folder, null: true

    def resolve(id:, **kwargs)
      @id = id
      update_folder(kwargs)
    end

    def update_folder(kwargs)
      # TODO: add workspace and env management
      folder.update(id: @id, **kwargs, relative_path: "#{kwargs[:relative_path]}/#{kwargs[:identifer]}")
      folder
    end

    def folder
      @folder ||= ::CloudStore::Folder.find(@id)
    end
  end
end
