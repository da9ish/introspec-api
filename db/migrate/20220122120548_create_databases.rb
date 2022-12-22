# frozen_string_literal: true

class CreateDatabases < ActiveRecord::Migration[6.1]
  def change
    create_table :databases do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.references :environment

      t.timestamps
    end

    add_index :databases, :name
    add_index :databases, :identifier, unique: true
  end
end
