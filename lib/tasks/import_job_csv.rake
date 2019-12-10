require "csv"

namespace :import_job_csv do
  desc "Import CSV file into database"
  task import_job: :environment do
    CSV.foreach("db/Venjob.csv", headers: true) do |row|
      company_params = {
                        email: row["contact email"],
                        name: row["company name"],
                        address: row["company address"],
                        code: row["company id"]
                        }
      Company.create!(company_params)
      job_params = {
                    company_id: Company.find_by(code: row["company id"]).id,
                    location: row["workplace"],
                    title: row["name"],
                    description: row["description"],
                    position: row["level"],
                    salary: row["salary"],
                    requirement: row["requirement"]
                    }
      Job.create!(job_params)
    end
  end
end
