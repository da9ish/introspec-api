# frozen_string_literal: true

class CreateWorkspaces < ActiveRecord::Migration[6.1]
  def change
    create_table :workspaces do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :public_api_key
      t.references :user

      t.timestamps null: false
    end

    add_index :workspaces, :identifier, unique: true
  end
end
