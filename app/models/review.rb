class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :user, presence: true
  validates :review, presence: { message: "Review cannot be blank" }, length: { minimum: 5, message: "Review must be at least 5 characters" }
end
