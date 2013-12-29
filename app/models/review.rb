class Review < ActiveRecord::Base
  belongs_to :movie

  validates :full_name, presence: true

  STARS = [1, 2, 3, 4, 5]

  validates :stars, inclusion: {in: STARS, message: "must be between 1 and 5"}

  validates :comment, length: { minimum: 3, message: "must be greater then or equal to three characters" }
end
