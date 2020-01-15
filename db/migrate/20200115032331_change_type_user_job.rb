class ChangeTypeUserJob < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_jobs, :job_type, :type
  end
end
