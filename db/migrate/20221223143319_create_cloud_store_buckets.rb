# frozen_string_literal: true

class CreateCloudStoreBuckets < ActiveRecord::Migration[6.1]
  def change
    create_table :buckets do |t|
      t.string :name, null: false
      t.string :identifier, null: false
      t.references :environment

      t.timestamps
    end

    add_index :buckets, :name
    add_index :buckets, :identifier, unique: true
  end
end
