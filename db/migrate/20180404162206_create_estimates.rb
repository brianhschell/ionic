class CreateEstimates < ActiveRecord::Migration[5.1]
  def change
    create_table :estimates do |t|
      t.integer :sub_id
      t.float :amount
      t.text :notes
      t.string :event_type
      t.datetime :event_date
      t.timestamps
    end
    add_column :projects, :end_date, :datetime
    add_column :images, :project_id, :integer
    add_column :images, :estimate_id, :integer
    add_column :sub_details, :invoice, :integer, :default=> 0
  end
end
