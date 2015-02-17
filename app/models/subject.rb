class Subject < ActiveRecord::Base
  belongs_to :course
  has_many :tasks, dependent: :destroy
  #has_many :tests, dependent: :destroy
  accepts_nested_attributes_for :tasks
end
