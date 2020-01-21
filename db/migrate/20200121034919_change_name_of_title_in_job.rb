class ChangeNameOfTitleInJob < ActiveRecord::Migration[6.0]
  def change
    rename_column :jobs, :title, :name
  end
end
