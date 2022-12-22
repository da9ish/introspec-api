# frozen_string_literal: true

class CreateColumns < ActiveRecord::Migration[6.1]
  def change
    create_table :columns do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :data_type, null: false
      t.boolean :is_indexed, default: false
      t.string :constraints, array: true, default: []
      t.references :table

      t.timestamps
    end

    add_index :columns, :name
    add_index :columns, :is_indexed
    add_index :columns, %i[identifier table_id], unique: true
  end
end
