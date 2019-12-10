class ChangeIntegerLimitJob < ActiveRecord::Migration[6.0]
  def change
    change_column :jobs, :company_id, :integer, limit: 8
  end
end
