class ClientsPdf < Prawn::Document

	def initialize(clients)
		super(top_margin: 70)
		@cliente = clients
		@cliente.each do |clt|
		text "Cliente: #{clt.nombre}"
	end
	end
end