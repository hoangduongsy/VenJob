require "csv"

  namespace :job do
    desc "Import CSV file into database"
    task import_csv: :environment do
      csv_file = Settings.import_job.csv_file
      CSV.foreach(csv_file, headers: true) do |row|
        company_params = {
          email: row["contact email"],
          name: row["company name"],
          address: row["company address"]
        }
        company = Company.find_or_initialize_by(code: row["company id"])
        company.update(company_params)

        job_params = {
          description: row["description"],
          level: row["level"],
          salary: row["salary"],
          requirement: row["requirement"]
        }
        job = Job.find_or_initialize_by(name: row["name"], company_id: company.id)
        job.update(job_params)

        city_params = { region: row["work place"] }
        city = City.find_or_initialize_by(name: row["company province"])
        city.update(city_params)
        CityJob.find_or_create_by(job_id: job.id, city_id: city.id)

        industry_params = { name: row["category"] }
        industry = Industry.find_or_initialize_by(name: row["category"])
        industry.update(industry_params)
        IndustryJob.find_or_create_by(job_id: job.id, industry_id: industry.id)
      rescue
        import_logger = ActiveSupport::Logger.new("log/import.log")
        import_logger.error "Skip #{row}"
        next
      end
    end
  end
