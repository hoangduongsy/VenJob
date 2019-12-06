class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :short_description
      t.integer :company_id
      t.decimal :salary
      t.integer :currency
      t.text :requirement
      t.string :position
      t.datetime :posted_at
      t.datetime :expired_at

      t.timestamps null: false
    end
  end
end
