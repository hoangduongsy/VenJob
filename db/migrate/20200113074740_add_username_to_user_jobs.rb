class AddUsernameToUserJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :user_jobs, :username, :string
  end
end
