# frozen_string_literal: true

class CreateColumns < ActiveRecord::Migration[6.1]
  def change
    create_table :columns do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :data_type, null: false
      t.string :contraints, array: true, default: []

      t.boolean :index, default: false

      t.references :table

      t.timestamps
    end
  end
end
