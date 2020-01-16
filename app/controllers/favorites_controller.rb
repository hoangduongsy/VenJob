class FavoritesController < ApplicationController
  before_action :check_user_logged_in?
  before_action :load_job

  def index
    @favorites = current_user.favorites.includes(:job)
  end

  def create
    @favorite = current_user.favorites.find_or_create_by(job_id: @job.id)
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
  end

  private

  def load_job
    @job = Job.find_by(id: params[:job_id])
  end
end
