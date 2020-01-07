class JobsController < ApplicationController

  def index
    if params[:city_id].present?
      @jobs = City.find_by(id: params[:city_id]).jobs
    elsif params[:industry_id].present?
      @jobs = Industry.find_by(id: params[:industry_id]).jobs
    else
      @jobs = Job.all
    end

    @jobs = @jobs.page(params[:page]).per(Settings.all.job.limit)
  end
end
