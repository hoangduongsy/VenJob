require "rsolr"

namespace :search do
  desc "Connect to Solr server"
  task connect_solr: :environment do
    # Direct connection
    solr = RSolr.connect :url => "http://localhost:8983/solr/", update_format: :xml
    # Send a request to /select
    # response = solr.get '#', :params => {:q => 'Web' }
    puts solr.get 'venjob/query', :params => {:q => params[:search] }
  end
end
