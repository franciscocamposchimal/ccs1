class ClientsPdf < Prawn::Document
	def initialize(clients)
		super(top_margin: 70)
		@cliente = clients
		line_items
	end


	def line_items
		move_down 20
		table line_item_rows do
			row(0).font_style = :bold
			columns(1..3).align = :right
			self.row_colors = ['2ECCFA', 'FFFFFF']
		end
	end


end
