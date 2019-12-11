require "csv"

namespace :job do
  desc "Import CSV file into database"
  task import_csv: :environment do
    csv_file = Settings.import_job.csv_file
    CSV.foreach(csv_file, headers: true) do |row|
      company_params = {
                        email: row["contact email"],
                        name: row["company name"],
                        address: row["company address"],
                        code: row["company id"]
                        }
      company = Company.find_or_initialize_by(code: row["company id"])
      company.update(company_params)

      job_params = {
                    company_id: company.id,
                    title: row["name"],
                    description: row["description"],
                    position: row["level"],
                    salary: row["salary"],
                    requirement: row["requirement"]
                    }
      job = Job.find_or_initialize_by(title: row["name"])
      job.update(job_params)
      rescue
        import_logger = ActiveSupport::Logger.new("log/import.log")
        import_logger.error "Skip #{row}"
        next
    end
  end
end
