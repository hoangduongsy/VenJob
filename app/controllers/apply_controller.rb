class ApplyController < ApplicationController
  before_action :check_user_logged_in?
  before_action :load_job, only: [:new, :done, :confirm]

  def new
    @apply = if params[:apply].present?
               current_user.applies.new(apply_job_params)
             else
               current_user.applies.new
             end
  end

  def confirm
    @apply = current_user.applies.new(apply_job_params)
  end

  def done
    @apply = current_user.applies.new(apply_job_params)
    if @apply.save
      flash[:success] = "Your application has been saved successfully!"
    else
      render :new
    end
  end

  private

  def load_job
    @job = Job.find_by(id: params[:job_id])
  end

  def apply_job_params
    params.require(:apply)
          .permit(:cv_url, :first_name, :last_name, :username, :email)
          .merge(job_id: @job.id)
  end
end
