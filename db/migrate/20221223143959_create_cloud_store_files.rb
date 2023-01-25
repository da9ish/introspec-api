# frozen_string_literal: true

class CreateCloudStoreFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :files do |t|
      t.string :name, null: false
      t.string :identifier, null: false
      t.bigint :size, null: false
      t.string :file_type, null: false
      t.string :relative_path, null: false
      t.references :folder
      t.references :bucket

      t.timestamps
    end

    add_index :files, :name
    add_index :files, %i[identifier folder_id], unique: true
    add_index :files, %i[identifier bucket_id], unique: true
  end
end
