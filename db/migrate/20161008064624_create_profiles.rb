class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :fullname
      t.string :title
      t.string :company
      t.string :position
      t.string :url

      t.timestamps
    end
    add_index :profiles, :fullname
  end
end
