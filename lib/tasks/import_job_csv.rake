require "csv"

namespace :import_job_csv do
  desc "Import CSV file into database"
  task create_job: :environment do
    file = "db/Venjob.csv"
    CSV.foreach(file, headers: true) do |row|
      job_hash = row.to_hash
      job = Job.where(id: job_hash["id"])
      if job.count == 1
        job.first.update_attributes(job_hash)
      else
        Job.create!({
                      company_id: row[4],
                      company_name: row[5],
                      location: row[16],
                      title: row[9],
                      description: row[7],
                      position: row[8],
                      salary: row[11],
                      requirement: row[10]
        })
      end
    end
  end
end
