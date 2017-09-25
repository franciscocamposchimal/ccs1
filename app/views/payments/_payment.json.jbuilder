json.extract! payment, :id, :num_pago, :monto, :fecha_pago, :status, :registro, :client_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
