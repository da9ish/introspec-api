# frozen_string_literal: true

class CreateEnvironments < ActiveRecord::Migration[6.1]
  def change
    create_table :environments do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.references :workspace

      t.timestamps
    end

    add_index :environments, %i[identifier workspace_id], unique: true
  end
end
