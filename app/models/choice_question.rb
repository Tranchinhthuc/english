class ChoiceQuestion < ActiveRecord::Base
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :users, through: :answers

  accepts_nested_attributes_for :answers
end
