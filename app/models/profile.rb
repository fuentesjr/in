class Profile < ApplicationRecord
  has_and_belongs_to_many :skills

  validates_presence_of :fullname
  paginates_per 5

  scope :search_by_fullname, ->(query) {
    where("LOWER(fullname) LIKE ?", "#{query.downcase}%")
    .includes(:skills)
  }
  scope :search_by_skills, ->(query) {
    joins(:skills)
    .merge(Skill.where("name = ?", query))
  }


  def as_json(options={})
    super(except: [:url], include:  {
      :skills => {:only => [:name]}
    })
  end
end
