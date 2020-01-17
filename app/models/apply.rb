class Apply < UserJob
  # delegate :title, :applied_at, :description, :salary, :position, :requirement, to: :user_jobs, prefix: :true
end
