class RemoveNotNullConstraintFromProfilesSkills < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles_skills, :created_at, :datetime, :null => true
    change_column :profiles_skills, :updated_at, :datetime, :null => true
  end
end
