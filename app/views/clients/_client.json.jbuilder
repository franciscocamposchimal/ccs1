json.extract! client, :status, :nombre, :apellidos, :tipo, :localidad, :direccion, :celular, :ine, :ruta, :grupo, :monto, :visita
json.url client_url(client, format: :json)
