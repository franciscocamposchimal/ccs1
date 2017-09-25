class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.text :registro
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
