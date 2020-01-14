class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_jobs
  has_many :apply_jobs

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/

  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username, presence: true,
                       length: { minimum: 6, maximum: 50 },
                       format: { with: VALID_USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }
  validates :first_name, presence: true,
                         length: { maximum: 50 },
                         format: { with: VALID_USERNAME_REGEX }
  validates :last_name, presence: true,
                        length: { maximum: 50 },
                        format: { with: VALID_USERNAME_REGEX }
end
