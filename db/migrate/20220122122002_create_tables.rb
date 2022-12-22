# frozen_string_literal: true

class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :tables do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.references :database

      t.timestamps
    end

    add_index :tables, :name
    add_index :tables, %i[identifier database_id], unique: true
  end
end
