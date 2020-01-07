class ChangeSalaryInJobs < ActiveRecord::Migration[6.0]
  def change
    change_column :jobs, :salary, :string
  end
end
