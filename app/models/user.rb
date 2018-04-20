class User < ActiveRecord::Base
  has_secure_password
  has_many :organizations
  has_many :joins
  has_many :orgs_attending, through: :joins, source: :organization

  email_regex = /\A([\w+-].?)+@[a-z\d-]+(.[a-z]+)*.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: email_regex }
  validates :first_name, :last_name, :email, presence:true
  validates :first_name, :last_name, length:{minimum:2, message:"must be at least 2 characters"}

  private

  def password_length
    errors.add(:password, "is too short! Make it longer") if password.length < 5
  end
end
