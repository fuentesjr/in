class MatViewProfile < ApplicationRecord

  def self.refresh
    Scenic.database.refresh_materialized_view(:mat_view_profiles, concurrently: true, cascade: false)
  end

  def as_json(options={})
    super.tap do |hash|
      hash['skills'] = skills_as_coll if hash['skills']
    end
  end

  private
    def skills_as_coll
      self.skills.split(", ").map {|s| {name: s} }
    end

end
