class CreateConnections < ActiveRecord::Migration[8.0]
  def change
    create_table :connections do |t|
      t.references :user, null: false, foreign_key: true
      t.string :relation
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
