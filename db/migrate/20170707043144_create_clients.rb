class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :status, default: "Activo"
      t.string :nombre
      t.string :apellidos
      t.string :tipo
      t.string :localidad
      t.string :direccion
      t.string :celular
      t.string :ine
      t.integer :ruta
      t.integer :grupo
      t.integer :monto
      t.date :visita

      t.timestamps
    end
  end
end
