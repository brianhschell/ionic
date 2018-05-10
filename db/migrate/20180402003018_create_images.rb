class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.integer :sub_detail_id
      t.string :description
      t.string :file,           :null => false
      t.string :image_type

      t.timestamps
    end
  end
end
