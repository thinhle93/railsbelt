class Organization < ActiveRecord::Base
  belongs_to :user
  has_many  :joins, dependent: :delete_all
  has_many :attendance, through: :joins, source: :user, dependent: :delete_all

  validates :name, :description, presence: true
  validates :name, length: {minimum: 5}
  validates :description, length: {minimum: 10}
end
