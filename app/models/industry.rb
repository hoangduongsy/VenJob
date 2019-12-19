class Industry < ApplicationRecord
  has_many :industry_jobs
  has_many :jobs, through: :industry_jobs

  def self.sort_top_industries
    @industries ||= all.sort_by(&:jobs_count).reverse
  end

  def jobs_count
    @jobs_count ||= jobs.count
  end
end
