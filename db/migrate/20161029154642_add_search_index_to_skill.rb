class AddSearchIndexToSkill < ActiveRecord::Migration[5.0]
  def change
    add_index :skills, :name
  end
end
