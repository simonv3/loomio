class Device < ApplicationRecord
  belongs_to :user
  validates :token, presence: true
end