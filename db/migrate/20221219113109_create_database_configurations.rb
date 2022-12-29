# frozen_string_literal: true

class CreateDatabaseConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :database_configurations do |t|
      t.string :name, null: false
      t.string :identifier, null: false
      t.string :host
      t.string :port, null: false
      t.string :allocated_storage, null: false
      t.string :db_instance_class, null: false
      t.string :db_instance_identifier, null: false
      t.string :engine, null: false
      t.string :db_name, null: false
      t.string :username, null: false
      t.string :encrypted_password, null: false
      t.string :status, null: false
      t.jsonb  :raw_response

      t.references :database

      t.timestamps
    end

    add_index :database_configurations, :name
    add_index :database_configurations, :identifier, unique: true
  end
end
