class Test < ActiveRecord::Base
  #belongs_to :course
  has_many :choice_questions, dependent: :destroy
  belongs_to :task
  accepts_nested_attributes_for :choice_questions
end
