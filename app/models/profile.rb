class Profile < ApplicationRecord
  has_and_belongs_to_many :skills

  validates_presence_of :fullname

  def as_json(options={})
    super(except: [:url], include:  {
      :skills => {:only => [:name]}
    })
  end
end
