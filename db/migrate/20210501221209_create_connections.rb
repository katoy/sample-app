class CreateConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :connections, id: false do |t|
      t.string :id, null: false, limit: 26, primary_key: true, comment: 'ID'

      t.references :user, type: :string, limit: 26, foreign_key: true
      t.references :task, type: :string, limit: 26, foreign_key: true
      t.timestamps
    end
  end
end
