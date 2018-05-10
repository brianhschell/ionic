class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :project_id, :integer
    create_table :projects do |t|
      t.string :name
      t.datetime :start_date
      t.timestamps
    end
  end
end
