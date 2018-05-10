class CreateSubDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :sub_details do |t|
      t.integer :sub_id
      t.float :amount
      t.text :notes
      t.string :event_type
      t.datetime :event_date
      t.timestamps
    end
  end
end
