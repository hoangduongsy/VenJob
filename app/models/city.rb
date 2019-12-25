class City < ApplicationRecord
  has_many :city_jobs
  has_many :jobs, through: :city_jobs

  def self.sort_top_cities
    @cities ||= includes(city_jobs: :job).all.sort_by(&:jobs_count).reject{ |city| city.jobs_count.zero? }.reverse.take(Settings.top.city.limit)
  end

  def self.sort_top_vn_cities
    @vn_cities ||= City.where(region: 0).includes(:city_jobs).sort_by(&:jobs_count).reject{ |city| city.jobs_count.zero? }.reverse.take(Settings.top.city.limit)
  end

  def self.sort_top_inter_cities
    @inter_cities ||= City.where(region: 1).includes(:city_jobs).sort_by(&:jobs_count).reject{ |city| city.jobs_count.zero? }.reverse.take(Settings.top.city.limit)
  end

  def jobs_count
    @jobs_count ||= jobs.count
  end
end
