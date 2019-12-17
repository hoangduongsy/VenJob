class Job < ApplicationRecord
  has_many :user_jobs
  has_many :city_jobs

  def self.latest_city
    @latest = Job.order(created_at: :desc)
  end
end
