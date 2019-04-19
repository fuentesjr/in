class MatViewProfile < ApplicationRecord
  self.primary_key = :my_unique_identifier_field

  def self.refresh
    Scenic.database.refresh_materialized_view(:mat_view_profiles, concurrently: true, cascade: false)
  end
end
