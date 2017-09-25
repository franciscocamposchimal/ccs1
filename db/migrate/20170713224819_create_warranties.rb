class CreateWarranties < ActiveRecord::Migration[5.1]
  def change
    create_table :warranties do |t|
      t.string :garantia1
      t.string :garantia2
      t.string :garantia3
      t.string :garantia4
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
