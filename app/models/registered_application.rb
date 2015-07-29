class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, length: {minimum: 2}, presence: true
  validates :url, length: {minimum: 5}, presence: true
  validates :user, presence: true
  validates_uniqueness_of :url, scope: :user_id
  validates_uniqueness_of :name, scope: :user_id
end
