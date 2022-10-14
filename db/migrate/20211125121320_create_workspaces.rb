# frozen_string_literal: true

class CreateWorkspaces < ActiveRecord::Migration[6.1]
  def change
    create_table :workspaces do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :public_api_key

      t.timestamps null: false
    end

    add_index :workspaces, :identifier, unique: true
    add_index :workspaces, :name, unique: true
    add_index :workspaces, :public_api_key, unique: true
  end
end
