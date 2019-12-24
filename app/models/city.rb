class City < ApplicationRecord
  has_many :city_jobs
  has_many :jobs, through: :city_jobs

  def self.sort_top_cities
    @cities ||= all.sort_by(&:jobs_count).reject{ |city| city.jobs_count.zero? }.reverse.take(Settings.top.city.limit)
  end

  def self.sort_top_vn_cities
    @vn_cities ||= where(region: 0).sort_by(&:jobs_count).reject{ |city| city.jobs_count.zero? }.reverse.take(Settings.top.city.limit)
  end

  def self.sort_top_inter_cities
    @inter_cities ||= where(region: 1).sort_by(&:jobs_count).reject{ |city| city.jobs_count.zero? }.reverse.take(Settings.top.city.limit)
  end

  def jobs_count
    @jobs_count ||= jobs.count
  end
end
