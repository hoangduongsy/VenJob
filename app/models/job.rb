class Job < ApplicationRecord
  has_many :user_jobs
  has_many :city_jobs
  scope :latest_job, -> {order(created_at: :desc).limit 5}
end
