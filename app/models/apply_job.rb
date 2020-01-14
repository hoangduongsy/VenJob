class ApplyJob < UserJob
  belongs_to :users
  belongs_to :jobs
end
