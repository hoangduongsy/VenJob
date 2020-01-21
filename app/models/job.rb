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

  def self.sync_to_solr
    solr = RSolr.connect(url: 'http://127.0.0.1:8983/solr/venjob')
    find_each do |job|
      job_info = {id: job.id,
        description: job.description,
        requirement: job.requirement,
        level: job.level,
        name: job.name,
        salary: job.salary }
        solr.add job_info
      end
   solr.commit
  end

end
