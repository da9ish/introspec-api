# frozen_string_literal: true

class CreateColumns < ActiveRecord::Migration[6.1]
  def change
    create_table :columns do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :data_type, null: false
      t.string :contraints, array: true, default: []
      t.references :table

      t.timestamps
    end

    add_index :columns, :identifier, unique: true
  end
end
