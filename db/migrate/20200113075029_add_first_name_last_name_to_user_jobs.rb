class AddFirstNameLastNameToUserJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :user_jobs, :first_name, :string
    add_column :user_jobs, :last_name, :string
  end
end
