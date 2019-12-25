class IndustriesController < ApplicationController
  def index
    @top_industries = Industry.sort_top_industries
  end
end
