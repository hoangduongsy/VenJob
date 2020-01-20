class JobsController < ApplicationController
  def index
    if params[:city_id].present?
      @jobs = City.find_by(id: params[:city_id]).jobs
    elsif params[:industry_id].present?
      @jobs = Industry.find_by(id: params[:industry_id]).jobs
    elsif params[:search].present?
      # @job_search = Job.search(params[:search])
      solr = Job.connect_rsolr
      results = solr.get "venjob/query", :params => { :q => params[:search] }

      @jobs = results["response"]["docs"].map do |job|
        OpenStruct.new job
      end

      # solr.paginate 1, 10, "venjob/query", :params => {:q => params[:search]}
    else
      @jobs = Job.all

    end

    # @jobs = @jobs.page(params[:page]).per(Settings.all.job.limit)
  end

  def show
    @job = Job.find_by(id: params[:job_id])
  end

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml { render :xml => @jobs }
    end
end

private

def job_search_params
  params.require(:job).permit(:title, :description, :search)
end
