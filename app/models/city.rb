class City < ApplicationRecord
  has_many :city_jobs
  has_many :jobs, through: :city_jobs

  def self.sort_top_cities
    @cities||= all.sort_by(&:jobs_count).reverse
  end

  def jobs_count
    @jobs_count = jobs.count
  end
end
