# frozen_string_literal: true

class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :tables do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :indexes, array: true, default: []
      t.string :contraints, array: true, default: []
      t.references :database

      t.timestamps
    end

    add_index :tables, :identifier, unique: true
  end
end
