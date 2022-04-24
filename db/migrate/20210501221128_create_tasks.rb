class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, id: false do |t|
      t.string :id, limit: 26, primary_key: true, comment: 'ID'

      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end
