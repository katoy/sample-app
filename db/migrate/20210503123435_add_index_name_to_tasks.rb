class AddIndexNameToTasks < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks, :name, unique: true
    add_index :tasks, :status
    change_column_null :tasks, :name, false
    change_column_null :tasks, :status, false, false
    change_column_default :tasks, :status, from: nil, to: false
  end
end
