class UpdateMatViewProfilesToVersion2 < ActiveRecord::Migration[5.1]
  def change
    update_view :mat_view_profiles,
      version: 2,
      revert_to_version: 1,
      materialized: true
  end
end
