class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :num_pago
      t.integer :monto
      t.date :fecha_pago
      t.integer :multa, default: 0
      t.string :status, default: "pagado"
      t.text :registro
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
