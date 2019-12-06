class AddCodeToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :code, :string
  end
end
