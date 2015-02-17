class Task < ActiveRecord::Base
  belongs_to :subject
  has_many :tests
  accepts_nested_attributes_for :tests
end
