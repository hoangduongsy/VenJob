class CitiesController < ApplicationController
  def index
    @top_vn_cities = City.sort_top_vn_cities
    @top_inter_cities = City.sort_top_inter_cities
  end
end
