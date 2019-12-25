class TopController < ApplicationController
  def index
    @latest_jobs = Job.latest_jobs
    @top_cities = City.sort_top_cities
    @top_industries = Industry.sort_top_industries
  end
end
