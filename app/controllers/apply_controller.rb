class ApplyController < ApplicationController
  def done
    # ApplyMailer.notify(@apply).deliver
    # redirect_to done_path(@apply)
  end

  def new
    @apply = UserJob.new(user_job_params)
  end

  def confirm
    #binding.pry
    @job = Job.find_by(id: params[:job_id])
    @apply = current_user.apply_jobs.new(apply_job_params.merge(job_id: @job.id))
    # @apply = @job.user_job.new(user_job_param)
      if @apply.save
        redirect_to done_path
      end
  end

  def create
  end

  private

  def user_job_params
    params.permit(:job_id, :cv_url, :first_name, :last_name, :username, :email)
  end

  def apply_job_params
    params.permit(:job_id, :user_id, :cv_url, :first_name, :last_name, :username, :email)
  end
end
