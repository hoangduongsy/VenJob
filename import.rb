require "csv"
require "activerecord-import/base"

def import
  jobs=[]
  CSV.foreach("app/lib/Venjob.csv",headers: true) do |row|
    jobs << { title: row["name"],
              description: row["description"],
              company_id: row["company id"],
              salary: row["salary"],
              requirement: row["requirement"],
              position: row["level"]
    }
  end
  Job.import jobs
end
