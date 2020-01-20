class Job < ApplicationRecord
  has_many :user_jobs
  has_many :city_jobs
  has_many :industry_jobs
  has_many :cities, through: :city_jobs
  has_many :industries, through: :industry_jobs
  has_many :applies
  has_many :favorites

  validates_presence_of :title

  def self.latest_jobs
    @latest ||= order(created_at: :desc).take(Settings.top.job.limit)
  end

  def self.connect_rsolr
    rsolr ||= RSolr.connect :url => "http://localhost:8983/solr"
  end

end
