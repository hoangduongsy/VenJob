class AddCvUrlToUserJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :user_jobs, :cv_url, :text
  end
end
