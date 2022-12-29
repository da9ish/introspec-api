# frozen_string_literal: true

class CreateCloudStoreFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.string :name, null: false
      t.string :identifier, null: false
      t.string :relative_path, null: false
      t.references :bucket
      t.bigint :folder_id

      t.timestamps
    end

    add_index :folders, :name
    add_index :folders, :folder_id
    add_index :folders, %i[identifier bucket_id], unique: true
  end
end
