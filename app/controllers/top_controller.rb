class TopController < ApplicationController
  def index
    @latest_jobs = Job.latest_jobs.take(Settings.top.job.limit)
    @top_cities = City.sort_top_cities.take(Settings.top.city.limit)
  end
end
