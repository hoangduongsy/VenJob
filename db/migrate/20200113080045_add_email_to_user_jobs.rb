class AddEmailToUserJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :user_jobs, :email, :string
  end
end
