class AddColumnsToJob < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :location, :string
    add_column :jobs, :company_name, :string
  end
end
