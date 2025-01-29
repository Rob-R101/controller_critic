class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :user, presence: true
end
