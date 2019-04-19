class CreateMatViewProfiles < ActiveRecord::Migration[5.1]
  def change
    create_view :mat_view_profiles, materialized: true

    add_index :mat_view_profiles, :id, unique: true

    enable_extension "btree_gin"
    add_index :mat_view_profiles, :skills, using: 'gin'
  end
end
