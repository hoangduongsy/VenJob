class JobsController < ApplicationController
  def index
    @latest_jobs = Job.latest_city.take(5)
    @top_cities = City.sort_top_cities.take(9)
  end
end
