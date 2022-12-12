# frozen_string_literal: true

class CreateEarlyAccesses < ActiveRecord::Migration[6.1]
  def change
    create_table :early_accesses do |t|
      t.string :email

      t.timestamps
    end
    add_index :early_accesses, :email, unique: true
  end
end
