class Course < ActiveRecord::Base
  has_many :subjects, dependent: :destroy
  has_many :users

  accepts_nested_attributes_for :subjects
end
