class ChangeTypeUserJob < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_jobs, :job_type, :type
    change_column :user_jobs, :type, :string
  end
end
