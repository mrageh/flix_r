class Movie < ActiveRecord::Base

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :title, :duration, :released_on, presence: true

  validates :description, length: {minimum: 25}

  validates :total_gross, numericality: {greater_than_or_equal_to: 0}

  validates :rating, inclusion: {in: RATINGS }

  validates :image_file_name, allow_blank: true, format: {
  with: /\w+.(gif|jpg|png)\z/i,
  message: "must reference a GIF, JPG or PNG image"
  }

  has_many :reviews, dependent: :destroy

  def flop?
    (total_gross.blank? || total_gross < 50000000) && !cult_classic?
  end

  def cult_classic?
    reviews.count >= 50 && average_stars >= 4
  end

  def self.released
    where("released_on <= ?", Time.now).order("released_on DESC")
  end

  def image_blank?
    image_file_name.blank?
  end

  def average_stars
    reviews.average(:stars)
  end

  def any_reviews?
    !average_stars.blank?
  end
end
