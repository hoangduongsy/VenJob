class Job < ApplicationRecord
  has_many :user_jobs
  has_many :city_jobs

  def self.latest_jobs
    @latest ||= order(created_at: :desc).take(Settings.top.job.limit)
  end

  # def self.all_jobs
  #   @all_jobs ||= all.sort_by(& :created_at)
  # end
end
