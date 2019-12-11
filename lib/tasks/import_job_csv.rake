require "csv"

namespace :import_job_csv do
  desc "Import CSV file into database"
  task import_job: :environment do
    CSV.foreach("db/Venjob.csv", headers: true) do |row|
      company_params = {
                        email: row["Contact email"],
                        name: row["Company name"],
                        address: row["Company address"],
                        code: row["Company id"]
                        }
      Company.create!(company_params)
      rescue
        import_company_logger = ActiveSupport::Logger.new("log/import_company.log")
        import_company_logger.info "Skip #{row}"
        next
      job_params = {
                    company_id: Company.find_by(code: row["Company id"]).id,
                    location: row["Work place"],
                    title: row["Name"],
                    description: row["Description"],
                    position: row["Level"],
                    salary: row["Salary"],
                    requirement: row["Requirement"]
                    }
      Job.create!(job_params)
      rescue
        import_company_logger = ActiveSupport::Logger.new("log/import_job.log")
        import_company_logger.info "Skip #{row}"
        next
    end
  end
end
