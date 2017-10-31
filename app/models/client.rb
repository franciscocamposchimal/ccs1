class Client < ApplicationRecord
  #validates :nombre, format:{ with: /[A-Z]/ } #SOLO MAYUSCULAS
	has_many :warranties, :dependent => :destroy
	accepts_nested_attributes_for :warranties, :allow_destroy => true

	has_and_belongs_to_many :avals, :dependent => :destroy
	accepts_nested_attributes_for :avals, reject_if: :valida_datos_aval?, :allow_destroy => true
	validates :avals, presence: { message: "el aval está repetido en la misma ruta o esta en blanco" }

	validates :visita, presence: { message: "no contiene ninguna fecha" }
	validates :monto, presence: { message: "no ingresado" }
	after_save :nombre_dia_semana
	validates :ine, length: {minimum: 18, maximum: 18}
	has_one :payment,:dependent => :destroy
	after_create :inserta

	has_many :records, :dependent => :destroy
	before_update :inserta_inactivo
 #SCOPES
    scope :ultimos, ->{ order("created_at DESC") }
    scope :activos, ->{ where(status: "Activo") }
	scope :inactivos, ->{ where.not(status: "Activo") }


    def inserta_inactivo

    	if self.status == "Inactivo"
    		client = Client.find(self.id)
    		client.payment.update(monto: calcula_pago_total(), fecha_pago: suma_dias(), multa: 0)
    	end
    end

# FUNCION PARA INSERTAR EN LA TABLA PAYMENT
	def inserta
		num_pago = 1
		monto = divide_pagos()
		fecha_pago = suma_dias()
		pago_total = calcula_pago_total()

			pagos = Payment.new(num_pago: num_pago, monto: pago_total, fecha_pago: fecha_pago, registro: "", client_id: self.id)
		    pagos.save!

	end
	def actualiza_pagos
		if self.status == "Activo"
			if self.payment.status == "Sin pagar"
			   self.payment.update(monto: self.payment.monto + 20, multa: self.payment.multa + 1 , status: "pagado")
	 	    end

		    if self.payment.num_pago == 14 && self.payment.multa == 0
		    	registro = Record.new(registro: self.payment.registro, client_id: self.id)
		        registro.save!
               self.update(monto: 0, status: "Inactivo")
         	   self.payment.update(num_pago: 1, monto: 0, registro: "")
		    end

            if self.payment.num_pago == 15
            	registro = Record.new(registro: self.payment.registro, client_id: self.id)
		        registro.save!
               self.update(status: "Inactivo")
         	   self.payment.update(num_pago: 1, monto: 0,registro: "")
            else
            	if self.status == "Activo"
            		 self.payment.update(num_pago: self.payment.num_pago + 1,monto: self.payment.monto - self.divide_pagos,  fecha_pago: self.siguiente,
			         registro: self.payment.registro+", Num. de pago: "+self.payment.num_pago.to_s+", Saldo anterior: "+self.payment.monto.to_s+", Fecha semana anterior: "+self.payment.fecha_pago.to_s)
            	end

            end
		end
	end

#FIN DE INSERTA

#VALIDACION PARA NO REPETIR AVALES EN LA MISMA RUTA
	def valida_datos_aval?(attributes)
		if Aval.joins(:clients).where('avals.nombre = ? AND avals.apellidos = ? AND clients.ruta = ?',attributes['nombre'],attributes['apellidos'],self.ruta).exists?
			errors.add(:ruta, "El Aval ya ha sido asignado a esta ruta")
		end
	end
#FIN DE LA VALIDACION
#FUNCIONES PARA CALCULAR PAGOS
  	def calcula_pago_total
  	  	monto = self.monto
  		tipo_cliente = self.tipo
  		if tipo_cliente == "colocadora"
  			monto = ((monto* 0.00)+monto).to_i
  		else
  			monto = ((monto* 0.50)+monto).to_i
  		end
  	end

  	def divide_pagos
  	       monto = calcula_pago_total()
  	       total = monto / 15
  	       return total
  	end
#FIN DE CALCULAR PAGOS
#fUNCIONES PARA CALCULAR LAS SEMANAS

		def nombre_dia_semana
		  if self.status == "Activo"
			dia_nombre = self.visita.strftime("%A")
			if dia_nombre == "Monday"
				dia_nombre = "Lunes"
			elsif dia_nombre == "Tuesday"
				dia_nombre = "Martes"
			elsif dia_nombre == "Wednesday"
				dia_nombre = "Miercoles"
			elsif dia_nombre == "Thursday"
				dia_nombre = "Jueves"
			elsif dia_nombre == "Friday"
				dia_nombre = "Viernes"
			elsif dia_nombre == "Saturday"
				dia_nombre = "Sábado"
			elsif dia_nombre == "Sunday"
				dia_nombre = "Domingo"
			end
		 end
		end


		def suma_dias

				anio = self.visita.strftime("%Y")
			   mes = self.visita.strftime("%m")
			   dia = self.visita.strftime("%d")
			   dia_int = self.visita.wday
			   dias_mes_actual = days_in_month(anio,mes)
			   suma = suma_dia(dia_int,dia)

			if suma.to_i > dias_mes_actual
				    corregir = suma - dias_mes_actual
	    			mes_sum = (mes.to_i)+1
	    		if mes_sum > 12 && suma > dias_mes_actual
	    			corregir = suma - dias_mes_actual
	    			mes_sum = 01
	    			anio_sum = (anio.to_i)+1
	    			fecha = convierte_fechas(anio_sum,mes_sum,corregir)
			        return fecha
			    end
			        fecha = convierte_fechas(anio,mes_sum,corregir)
			    	return fecha
			end

			fecha = convierte_fechas(anio,mes,suma)
		    return fecha


		end

		def suma_dia (dia_int,dia)

			if dia_int == 0
				sumado = (dia.to_i)+1
				elsif dia_int == 1
					sumado = (dia.to_i)+7
				elsif dia_int == 2
					sumado = (dia.to_i)+6
			    elsif dia_int == 3
			    	sumado = (dia.to_i)+5
				elsif dia_int == 4
				    sumado = (dia.to_i)+4
				elsif dia_int == 5
					sumado = (dia.to_i)+3
				elsif dia_int == 6
				    sumado = (dia.to_i)+2
			end
			return sumado
		end

	    def convierte_fechas (anio,mes,suma)
	    	fecha_para_convertir = anio.to_s+"/"+mes.to_s+"/"+suma.to_s
	    	convierte = Date.parse(fecha_para_convertir)
	    	return convierte
	    end

	    def days_in_month(year,month)
	        days = Date.new(year.to_i, month.to_i, -1).day
	        return days.to_i
	    end

	    def siguiente

	    		anio = self.payment.fecha_pago.strftime("%Y")
			    mes = self.payment.fecha_pago.strftime("%m")
			    dia = self.payment.fecha_pago.strftime("%d")
			    dia_int = self.payment.fecha_pago.wday
			    dias_mes_actual = days_in_month(anio,mes)
			    suma = suma_dia(dia_int,dia)

			 if suma.to_i > dias_mes_actual
				    corregir = suma - dias_mes_actual
	    			mes_sum = (mes.to_i)+1
	    		if mes_sum > 12 && suma > dias_mes_actual
	    			corregir = suma - dias_mes_actual
	    			mes_sum = 01
	    			anio_sum = (anio.to_i)+1
	    			fecha = convierte_fechas(anio_sum,mes_sum,corregir)
			        return fecha
			    end
			        fecha = convierte_fechas(anio,mes_sum,corregir)
			    	return fecha
			 end

			fecha = convierte_fechas(anio,mes,suma)
		    return fecha

	    end

#FIN DE CALCULAR SEMANAS

end
