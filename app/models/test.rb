class Test < ActiveRecord::Base\bolongs_to :course
  has_many :choice_questions, dependent: :destroy
  belongs_to :task
end
