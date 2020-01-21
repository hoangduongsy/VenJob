class JobsController < ApplicationController
  def index
    if params[:city_id].present?
      @jobs = City.find_by(id: params[:city_id]).jobs
    elsif params[:industry_id].present?
      @jobs = Industry.find_by(id: params[:industry_id]).jobs
    elsif params[:search].present?
      # @job_search = Job.search(params[:search])
      solr = Job.connect_rsolr # connect Solr server
      results = solr.get "venjob/query", :params => { :q => params[:search] } # return result of searching
      #results = solr.paginate 1, 2, "venjob/query", :params => {:q => params[:search] }
      @result_search = results["responseHeader"]["params"]["q"]
      @result_count = results["response"]["numFound"]
        #binding.pry
      job_ids = results["response"]["docs"].map{ |doc| doc['id'].to_i }
      @jobs=Job.where(id:job_ids).to_a
      #binding.pry
      return  @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(3)
      @jobs = Job.all

    end
    @jobs = @jobs.page(params[:page]).per(Settings.all.job.limit)
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
