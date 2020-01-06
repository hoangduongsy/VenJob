class JobsController < ApplicationController
  def index
    @all_jobs = Job.all.page(params[:page]).per(20)
  end
end
