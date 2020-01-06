class JobsController < ApplicationController
  def index
    @jobs = Job.all.page(params[:page]).per(Settings.all.job.limit)
  end
end
