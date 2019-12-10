class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :email
      t.text :description
      t.string :address
      t.string :url
      t.string :name

      t.timestamps null: false
    end
  end
end
