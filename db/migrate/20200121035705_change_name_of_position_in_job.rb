class ChangeNameOfPositionInJob < ActiveRecord::Migration[6.0]
  def change
    rename_column :jobs, :position, :level
  end
end
