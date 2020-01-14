class ApplyController < ApplicationController
  before_action :load_job, only: [:new, :done, :confirm]

  def done
    binding.pry
    @apply = UserJob.new(apply_job_params)
    if @apply.save
      redirect_to done_path
    else
      render :new
    end
  end

  def new
    @apply = UserJob.new
  end

  def confirm
    @apply = UserJob.new(apply_job_params)
  end

  private

  def apply_job_params
    params.require(:user_job).permit(:cv_url, :first_name, :last_name, :username, :email)
  end

  def load_job
    @job = Job.find_by(id: params[:job_id])
  end
end
