# Configuración de cliente de MercadoPago
	# Credenciales de cliente

		CLIENT_ID = MpKey.find(1).client_id.to_s
		CLIENT_SECRET = MpKey.find(1).client_secret.to_s

	# Credenciales de modo Sandbox

		PUBLIC_KEY = MpKey.find(1).public_key.to_s
		ACCESS_TOKEN = MpKey.find(1).access_token.to_s

	# Cliente de MercadoPago

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