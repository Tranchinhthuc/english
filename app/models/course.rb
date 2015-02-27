class Course < ActiveRecord::Base
  has_many :subjects, dependent: :destroy
  has_many :course_users
  has_many :users, through: :course_users

  accepts_nested_attributes_for :subjects
end
