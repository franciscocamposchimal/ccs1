class CreateAvals < ActiveRecord::Migration[5.1]
  def change
    create_table :avals do |t|
      t.string :nombre
      t.string :apellidos
      t.string :ine
      t.string :direccion
      t.string :celular


      t.timestamps
    end
  end
end
