# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190419051013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "btree_gin"

  create_table "profiles", id: :serial, force: :cascade do |t|
    t.string "fullname"
    t.string "title"
    t.string "company"
    t.string "position"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fullname"], name: "index_profiles_on_fullname"
  end

  create_table "profiles_skills", id: false, force: :cascade do |t|
    t.integer "profile_id"
    t.integer "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["profile_id"], name: "index_profiles_skills_on_profile_id"
    t.index ["skill_id"], name: "index_profiles_skills_on_skill_id"
  end

  create_table "skills", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skills_on_name"
  end


  create_view "mat_view_profiles", materialized: true, sql_definition: <<-SQL
      SELECT profiles.id,
      profiles.fullname,
      string_agg((skills.name)::text, ', '::text) AS skills
     FROM ((profiles
       JOIN profiles_skills ON ((profiles_skills.profile_id = profiles.id)))
       JOIN skills ON ((skills.id = profiles_skills.skill_id)))
    GROUP BY profiles.id;
  SQL
  add_index "mat_view_profiles", ["id"], name: "index_mat_view_profiles_on_id", unique: true
  add_index "mat_view_profiles", ["skills"], name: "index_mat_view_profiles_on_skills", using: :gin

end
