# Configuración de cliente de MercadoPago
	# Credenciales de cliente

		CLIENT_ID = "7233176831657271"
		CLIENT_SECRET = "kXcwA8gBQfHWsPoaCivx8oJzwH49x3wx"

	# Credenciales de modo Sandbox

		PUBLIC_KEY = "TEST-04b51501-7da4-4183-a6bb-92a43914928d"
		ACCESS_TOKEN = "TEST-7233176831657271-111119-8c79dd636363e238c9442b16e284b4ed__LB_LA__-160276862"

	# Cliente de MercadoPagorai

		require 'mercadopago.rb'	

		MP_CLIENT = MercadoPago.new(CLIENT_ID, CLIENT_SECRET)
		MP_CLIENT.sandbox_mode(true)

	# Estructura JSON de un pago
		#preference_data = {
		#            "items": [
		#                {
		#                    "title": "product", 
		#                    "quantity": 1, 
		#                    "unit_price": 10.2, 
		#                    "currency_id": "ARS"
		#                }
		#            ]
		#        }