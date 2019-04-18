class Profile < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_fullname, against: :fullname
  pg_search_scope :search_by_skills, associated_against: {
    skills: [:name]
  }


  has_and_belongs_to_many :skills

  validates_presence_of :fullname
  paginates_per 5

  def as_json(options={})
    super(except: [:url], include:  {
      :skills => {:only => [:name]}
    })
  end
end
