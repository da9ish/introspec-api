# frozen_string_literal: true

class CreateStorageConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :storage_configurations do |t|
      t.string :name, null: false
      t.string :identifier, null: false
      t.string :location
      t.jsonb  :raw_response

      t.references :bucket

      t.timestamps
    end

    add_index :storage_configurations, :name
    add_index :storage_configurations, :identifier, unique: true
  end
end
