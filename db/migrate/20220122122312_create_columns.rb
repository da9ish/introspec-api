# frozen_string_literal: true

class CreateColumns < ActiveRecord::Migration[6.1]
  def change
    create_table :columns do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :data_type, null: false
      t.boolean :default_value
      t.boolean :is_array, default: false
      t.boolean :is_indexed, default: false
      t.boolean :is_primary, default: false
      t.boolean :is_unique, default: false
      t.boolean :is_nullable, default: false
      t.references :table

      t.timestamps
    end

    add_index :columns, :name
    add_index :columns, :is_array
    add_index :columns, :is_indexed
    add_index :columns, :is_primary
    add_index :columns, :is_unique
    add_index :columns, :is_nullable
    add_index :columns, %i[identifier table_id], unique: true
  end
end
