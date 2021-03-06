class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_many :courses, through: :course_users
  has_many :course_users
  has_secure_password
  before_save :downcase_email
  validates :name, presence: true, length: {maximum: 50}
  validates :password, length: { minimum: 6 }, allow_blank: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes!(remember_digest:User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes!(remember_digest:nil)
  end

  private
  def downcase_email
    self.email = email.downcase
  end

end