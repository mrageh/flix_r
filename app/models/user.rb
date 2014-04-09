class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_secure_password

  validates :email, presence: true,
    format: /\A\S+@\S+\z/,
    uniqueness: { case_sensitive: false }

  validates :name, presence: true
end
