class CreateSubTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :sub_types do |t|
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end
