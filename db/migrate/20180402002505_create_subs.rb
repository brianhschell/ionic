class CreateSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :subs do |t|
      t.integer :sub_type_id
      t.integer :project_id
      t.text :notes
      t.timestamps
    end
  end
end
