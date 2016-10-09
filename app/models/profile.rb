class Profile < ApplicationRecord
  validates_presence_of :fullname
end
