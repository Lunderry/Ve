local module = {
	["Español"] = {
		["Tutorial"] = {
			["Tutorial1"] = {
				{ "Es la primera vez que te veo", "Saludando" },
				{ "Primero que todo bienvenido al juego", "Listo" },
				{ "Que bueno que te animaste a aprender sobre fisica", "Lentes" },
				{ "Yo soy Vetty, te ayudare sobre el aprendizaje de fisica", "Dato" },
			},
			["Tutorial2"] = {
				{ "Abajo a la izquierda veras mi icono, solo tendras que darle click para ayudarte", "Dato" },
			},
		},

		["Base"] = {
			{ "¿Que deseas?", "Saludando" },
		},
		["Despedida"] = {
			{ "Adios aqui estare esperando", "Saludando" },
		},

		--Sin eleccion
		[""] = {},
		["ConversionNumeros"] = {
			["Conversiones"] = {
				["Conversion de Longitud"] = {
					{ "Primero tenemos que tener un orden de posición, que sería.", "Saludando" },
					{ "1 = mm, \n2 = cm, \n3 = dm, \n4 = m \n5 = dam \n6 = hm \n7 = km", "Lentes" },
					{
						"Un ejemplo: \n Si el primer número es 20 milímetros (mm) y tenemos que convertirlo a metros (m), lo que tenemos que hacer es usando la tabla anterior una resta entre 4 - 1, donde el 4 significa que es (m)y el 1 que seria (mm).",
						"Escribiendo",
					},
					{ "En este caso nos da 3, ahora tenemos que dividir 20mm entre 1,000", "Dato" },
					{
						"El “1,000” sale agregando ceros con el resultado que nos dio, como en este caso fueron 3, se agregan 3 ceros al número divisor. Si fuera de milimetros a centimetros, nada más se agregaría un cero)",
						"Escribiendo",
					},
					{
						"para dar el resultado tendríamos que dividir 20mm entre 1,000 para que nos da .02 m",
						"Listo",
					},
					{
						"Pero si queremos hacerlo de manera inversa tenemos que hacer el mismo procedimiento solo que ahora sería multiplicando y restando al revés, en vez de (mm - m) a (m - mm)",
						"Escribiendo",
					},
				},
				["Conversion de Masa"] = {
					{ "Primero tenemos que tener un orden de posición, que sería el siguiente.", "Dato" },

					{ "1 = mg\n2 = cg\n3 = dg\n4 = g\n5 = dag\n6 = hg\n7 = kg", "Normal" },
					{
						"Un ejemplo: \nSi el primer número es  10 gramos (g) y tenemos que convertirlo a metros (kg), lo que tenemos que hacer es usando la tabla anterior una resta entre 7 - 4 , donde el 7 significa que es kilogramos y el 4 que sería gramos.",
						"Saludando",
					},
					{ "En este caso nos da 3, ahora tenemos que dividir 10g entre 1,000", "Lentes" },
					{
						"El “1,000” sale agregando ceros con el resultado que nos dio, como en este caso fueron 3, se agregan 3 ceros al número divisor. Si fuera de hectogramos a kilogramos, nada más se agregaría un cero",
						"Escribiendo",
					},
					{
						"Para dar el resultado tendríamos que dividir 10g entre 1,000.\nEl resultado es de .02 gramos.",
						"Listo",
					},
					{
						"Pero si queremos hacerlo de manera inversa tenemos que hacer el mismo procedimiento solo que ahora sería multiplicando y restando al revés, en vez de (g - kg) a (kg - g)",
						"Normal",
					},
				},
				["Conversion de Temperatura"] = {
					{ "Primero tenemos que ver que significa cada Temperatura", "Dato" },
					{
						"f = Fahrenheit \nk = Kelvins \nc = Celsius",
						"Lentes",
					},
					{
						"Kelvins:\n\nKelvins a Fahrenheit \nf = (k - 273.15) * 1.8 + 32\nKelvins a Celsius\n c = k - 273.15",
						"Escribiendo",
					},
					{
						"Celsius:\n\nCelsius a Kelvins k = c + 273.15\nCelsius a Fahrenheit\nf = (c * 1.8) + 32",
						"Escribiendo",
					},
					{
						"Fahrenheit:\n\nFahrenheit a Kelvins\nk = (f - 32) * 1.8 + 273.15\nFahrenheit  a Celsius\nc = (f - 32) * 1.8",
						"Escribiendo",
					},
				},
				["Conversion de Tiempo"] = {
					{
						"De segundos a minutos:\n\nDivide la cantidad de segundos entre 60 para obtener los minutos. El residuo serán los segundos restantes.",
						"Listo",
					},
					{ "Minutos = Segundos / 60 Segundos restantes = Segundos % 60", "Escribiendo" },

					{
						"De minutos a horas:\n\nDivide la cantidad de minutos entre 60 para obtener las horas. El residuo serán los minutos restantes.",
						"Dato",
					},
					{ "Horas = Minutos / 60 Minutos restantes = Minutos % 60", "Escribiendo" },
				},
				["Conversion Cuadrado/Cubico"] = {
					{
						"Usando el ejemplo de Longitud pero en caso del Cuadrado multiplicando por 20\n y por 30 usando el Cubico",
						"Dato",
					},
				},
			},
			["Tutorial"] = {
				["¿Como sirve?"] = {
					{ "En la parte de arriba tienes diferentes tipos de numeros para convertir", "Saludando" },
					{
						"y a su lado izquierdo saldra diferentes tipos de medidas dependiendo que tipo uso",
						"Dato",
					},
					{ "al dar click lo podra seleccionar para ponerlo en uno de los 2 cuadros grises", "Listo" },
					{
						"el cuadro gris de arriba es el numero que quiere convertir y el de abajo es a que se va a convertir",
						"Pensando",
					},
					{ "ya al tener esto puede poner los datos en el recuadro blanco de la parte arriba", "Saludando" },
				},
				["Datos"] = {
					["¿Para que sirve convertir numeros?"] = {
						{ "En muchas cosas", "Saludando" },
						{ "Aqui una lista de lo que sirve", "Dato" },
						{
							"Presentación de datos, Cálculos y comparaciones, Interacción con sistemas externos, Optimización de rendimiento, etc.",
							"Escribiendo",
						},
					},
				},
			},
		},
		["PlanoCartesiano"] = {
			["Operaciones"] = {
				["¿Como puedo saber la distancia entre dos puntos?"] = {
					{ "Tienes que tener la posición de ambos puntos", "Dato" },
					{ "Las restas sus lados ejem:\n\n x2 - x1, donde su número es su respectivo punto ", "Saludando" },
					{ "x2 sería el eje y x1 el punto.", "Listo" },
					{ "Y le pones un potencial al cuadrado quedaría:\n (x2 - x1)²", "Pensando" },
					{ "Hacemos lo mismo con su posición Y (y2 - y1)²", "Saludando" },
					{ "Ahora lo sumamos x + y", "Dato" },
					{ "Y por último le sacamos el raíz √", "Escribiendo" },
				},
				["¿Como puedo saber cuantos grados tiene?"] = {
					{
						"Tienes que restar (x2 - x1) y (y2 - y1) donde el 2 es el eje y el 1 el punto",
						"Dato",
					},
					{
						"Ahora usando tangente(y/x) y con el resultado ver dependiendo de la posicion si es positivo o negativo",
						"Saludando",
					},
				},
				["¿Como se que tipo de angulo tiene un plano?"] = {
					{
						'Si el punto se encuentra a la derecha del eje en un ángulo "Nulo / Completo" dependiendo del contexto',
						"Saludando",
					},
					{
						'"Nulo" si solo esta en el principio del Plano Cartesiano, "Completo" si ya dio la vuelta completa',
						"Dato",
					},
					{
						'Si el punto se encuentra antes de los 90° y después de 0° será un ángulo "Agudo"',
						"Listo",
					},
					{
						'Si el punto está arriba del eje que sería lo mismo a 90° será un ángulo "Recto"',
						"Normal",
					},

					{
						'Si el punto está después de los 90° y antes de 180° es un ángulo "Obtuso',
						"Escribiendo",
					},
					{
						'Si el punto se encuentra a la izquierda que seria lo mismo a 180° seria un ángulo "Llano"',
						"Listo",
					},
					{
						'Si los grados es mayor a 180° y menor a 360° seria un ángulo "Cóncavo"',
						"Saludando",
					},
				},
			},
		},
		["MovimientoRectilinio"] = {
			["Operaciones"] = {
				["Sacar datos con solo Velocidad Inicial"] = {
					{ "Datos para las formulas", "Saludando" },
					{ "d = Distancia\nvi = Velocidad Inicial\nt = Tiempo ", "Dato" },
					{ "d = vit", "Escribiendo" },
				},
				["Sacar datos con Aceleración"] = {
					{ "Datos para las formulas", "Saludando" },
					{ "d = Distancia\nvi = Velocidad Inicial\nt = Tiempo\na = Aceleracion", "Escribiendo" },
					{ "d = vit + .5at²", "Dato" },
					{ "v = vi + at", "Saludando" },
					{ "(Si no se tiene Velocidad Inicial se usa el numero 0)", "Listo" },
				},
			},
			["General Movimiento"] = {
				["¿Cómo funciona la interfaz?"] = {
					{
						"A tu izquierda tienes las configuraciones para que el sistema sepa qué propiedades quieres que tenga",
						"Listo",
					},
					{
						"A un lado tienes botones, el primero sirve para iniciar el objeto a un lado su botón de pausa",
						"Dato",
					},
					{
						"Tienes flechas donde te indica que velocidad quieres que tenga el tiempo de ejecución",
						"Escribiendo",
					},
					{
						'Y por ultimo a tu derecha datos sobre ese mismo mecanismo, datos como "Tiempo Máximo"',
						"Normal",
					},
				},
				["¿Cuales son los tipos de Configuraciones?"] = {
					{ "Existen tres tipos de configuraciones", "Dato" },
					{
						'El "Primero" son datos que tienes que ponerlas sin ninguna excepción',
						"Saludando",
					},
					{ 'El "Secundario" tienes que elegir entre sus opciones para elegir solo uno', "Dato" },
					{ 'El "Terciario" son datos opcionales  que no son vitales para el funcionamiento', "Saludando" },
				},
				["¿Cómo puedo cambiar el tiempo?"] = {
					{
						"Tienes que dar pausa y en los datos del experimento puedes mover su tiempo al que tu quieras",
						"Listo",
					},
				},
			},
		},
		-- {"", "Saludando"},
		--\n

		["CaidaLibre"] = {
			["Operaciones"] = {
				["Sacar datos de movimiento"] = {
					{
						"Los datos de movimiento son los que se generan mediante el movimiento del objeto.",
						"Saludando",
					},
					{ "Datos importantes.", "Dato" },
					{ "v = Velocidad\nh = Altura\nt = Tiempo", "Escribiendo" },
					{ "Datos extras serían:\ng = Gravedad", "Saludando" },
					{ "t = √2h / g", "Dato" },
					{ "v = gt", "Dato" },
					{ "h = gt² / 2", "Dato" },
				},
				["Sacar datos de como se moverá"] = {
					{ 'Estos datos predicen alguno datos como "TiempoMaximo" o/y "TiempoSubida"', "Saludando" },
					{ "Datos para las formulas", "Saludando" },
					{ "g = Gravedad\n h = Altura", "Dato" },
					{ "TiempoFinal = √2h / g", "Dato" },
					{ "AlturaRecorrer = gTf² / 2\n(TiempoFinal = Tf)", "Dato" },
				},
			},
			["General Movimiento"] = {
				["¿Cómo funciona la interfaz?"] = {
					{
						"A tu izquierda tienes las configuraciones para que el sistema sepa qué propiedades quieres que tenga",
						"Listo",
					},
					{
						"A un lado tienes botones, el primero sirve para iniciar el objeto a un lado su botón de pausa",
						"Dato",
					},
					{
						"Tienes flechas donde te indica que velocidad quieres que tenga el tiempo de ejecución",
						"Escribiendo",
					},
					{
						'Y por ultimo a tu derecha datos sobre ese mismo mecanismo, datos como "Tiempo Máximo"',
						"Normal",
					},
				},
				["¿Cuales son los tipos de Configuraciones?"] = {
					{ "Existen tres tipos de configuraciones", "Dato" },
					{
						'El "Primero" son datos que tienes que ponerlas sin ninguna excepción',
						"Saludando",
					},
					{ 'El "Secundario" tienes que elegir entre sus opciones para elegir solo uno', "Dato" },
					{ 'El "Terciario" son datos opcionales  que no son vitales para el funcionamiento', "Saludando" },
				},
				["¿Cómo puedo cambiar el tiempo?"] = {
					{
						"Tienes que dar pausa y en los datos del experimento puedes mover su tiempo al que tu quieras",
						"Listo",
					},
				},
			},
		},
		["TiroVertical"] = {
			["Operaciones"] = {
				["Sacar datos de movimiento"] = {
					{
						"Los datos de movimiento son los que se generan mediante el movimiento del objeto.",
						"Saludando",
					},
					{ "Datos para las formulas", "Saludando" },

					{ "g = Gravedad\nt = Tiempo\nvi = Velocidad Inicial\nv = Velocidad\nh = Altura", "Saludando" },
					{ "Altura = vit - (0.5 * g) * t²\n\nAltura = v² - vi² / (2 * -g)", "Dato" },
					{ "Tiempo = vi - v / g", "Listo" },
					{ "Velocidad = vi - gt", "Dato" },
				},
				["Sacar datos de como se movera"] = {
					{ 'Estos datos predicen como alguno datos como "TiempoMaximo" o/y "TiempoSubida".', "Saludando" },
					{ "Datos para las formulas", "Saludando" },
					{ "g = Gravedad\nvi = Velocidad Inicial", "Saludando" },
					{ "TiempoSubida = vi/g", "Dato" },
					{ "TiempoMaximo = TiempoSubida * 2", "Dato" },
					{ "AlturaMaxima = vi²/2g", "Listo" },
					{ "VelocidadFinal = vi - gvi/g *2 ", "Dato" },
				},
			},
			["General Movimiento"] = {
				["¿Cómo funciona la interfaz?"] = {
					{
						"A tu izquierda tienes las configuraciones para que el sistema sepa qué propiedades quieres que tenga",
						"Listo",
					},
					{
						"A un lado tienes botones, el primero sirve para iniciar el objeto a un lado su botón de pausa",
						"Dato",
					},
					{
						"Tienes flechas donde te indica que velocidad quieres que tenga el tiempo de ejecución",
						"Escribiendo",
					},
					{
						'Y por ultimo a tu derecha datos sobre ese mismo mecanismo, datos como "Tiempo Máximo"',
						"Normal",
					},
				},
				["¿Cuales son los tipos de Configuraciones?"] = {
					{ "Existen tres tipos de configuraciones", "Dato" },
					{
						'El "Primero" son datos que tienes que ponerlas sin ninguna excepción',
						"Saludando",
					},
					{ 'El "Secundario" tienes que elegir entre sus opciones para elegir solo uno', "Dato" },
					{ 'El "Terciario" son datos opcionales  que no son vitales para el funcionamiento', "Saludando" },
				},
				["¿Cómo puedo cambiar el tiempo?"] = {
					{
						"Tienes que dar pausa y en los datos del experimento puedes mover su tiempo al que tu quieras",
						"Listo",
					},
				},
			},
		},
		["TiroParabolico"] = {
			["Operaciones"] = {
				["Sacar datos de movimiento"] = {
					{ "Los datos de movimiento son los que se generan mediante el movimiento del objeto", "Saludando" },
					{ "Datos para las formulas", "Normal" },
					{ "g = Gravedad\nt = Tiempo\nvi = VelocidadInicial\ngra = Grados\ndis = Distancia", "Saludando" },
					{
						"Velocidad Horizontal (vx) = vi * cos(gra), ,\nVelocidad Vertical (vy) = vi * sin(gra),\n (Todos los calculos fueron hechos con radianes.) (vy)",
						"Escribiendo",
					},
					{ "Posicion Horizontal = vxt", "Listo" },
					{ "Posicion Vertical = vyt - .5gt²", "Dato" },
					{ "VelocidadInicial = √(-.5gt)² / sin(gra)²", "Listo" },
					{ "VelocidadInicial = √dis * g/ sin(2 * gra)", "Dato" },
				},
				["Sacar datos de como se movera"] = {
					{ 'Estos datos predicen como alguno datos como "TiempoMaximo" o/y "TiempoSubida"', "Normal" },
					{ "Datos para las formulas", "Saludando" },
					{ "g = Gravedad\ngra = Grados\nvi = VelocidadInicial", "Escribiendo" },
					{
						"Velocidad Horizontal (vx) = vi * cos(gra),\nVelocidad Vertical (vy) = vi * sin(gra),\n (Todos los calculos fueron hechos con radianes.)",
						"Escribiendo",
					},
					{ "TiempoSubida = vy/g", "Dato" },
					{ "AlturaMaxima = vy²/2g", "Listo" },
					{ "TiempoMaximo = 2vy / g", "Dato" },
					{ "AlcanceHorizontal = vx(vy/2g)", "Listo" },
				},
			},
			["General Movimiento"] = {
				["¿Cómo funciona la interfaz?"] = {
					{
						"A tu izquierda tienes las configuraciones para que el sistema sepa qué propiedades quieres que tenga",
						"Listo",
					},
					{
						"A un lado tienes botones, el primero sirve para iniciar el objeto a un lado su botón de pausa",
						"Dato",
					},
					{
						"Tienes flechas donde te indica que velocidad quieres que tenga el tiempo de ejecución",
						"Escribiendo",
					},
					{
						'Y por ultimo a tu derecha datos sobre ese mismo mecanismo, datos como "Tiempo Máximo"',
						"Normal",
					},
				},
				["¿Cuales son los tipos de Configuraciones?"] = {
					{ "Existen tres tipos de configuraciones", "Dato" },
					{
						'El "Primero" son datos que tienes que ponerlas sin ninguna excepción',
						"Saludando",
					},
					{ 'El "Secundario" tienes que elegir entre sus opciones para elegir solo uno', "Dato" },
					{ 'El "Terciario" son datos opcionales  que no son vitales para el funcionamiento', "Saludando" },
				},
				["¿Cómo puedo cambiar el tiempo?"] = {
					{
						"Tienes que dar pausa y en los datos del experimento puedes mover su tiempo al que tu quieras",
						"Listo",
					},
				},
			},
		},
	},
	["Ingles"] = {
		["Tutorial"] = {
			["Tutorial1"] = {
				{ "Es la primera vez que te veo", "Saludando" },
				{ "Primero que todo bienvenido al juego", "Listo" },
				{ "Que bueno que te animaste a aprender sobre fisica", "Lentes" },
				{ "Yo soy Vetty, te ayudare sobre el aprendizaje de fisica", "Dato" },
			},
			["Tutorial2"] = {
				{ "Abajo a la izquierda veras mi icono, solo tendras que darle click para ayudarte", "Dato" },
			},
		},

		["Base"] = {
			{ "¿Que deseas?", "Saludando" },
		},
		["Despedida"] = {
			{ "Adios aqui estare esperando", "Saludando" },
		},

		--Sin eleccion
		[""] = {},
		["ConversionNumeros"] = {
			["Conversiones"] = {
				["Conversion de Longitud"] = {
					{ "Primero tenemos que tener un orden de posición, que sería.", "Saludando" },
					{ "1 = mm, \n2 = cm, \n3 = dm, \n4 = m \n5 = dam \n6 = hm \n7 = km", "Saludando" },
					{
						"Un ejemplo: \n Si el primer número es 20 milímetros (mm) y tenemos que convertirlo a metros (m), lo que tenemos que hacer es usando la tabla anterior una resta entre 4 - 1, donde el 4 significa que es (m)y el 1 que seria (mm).",
						"Saludando",
					},
					{ "En este caso nos da 3, ahora tenemos que dividir 20mm entre 1,000", "Saludando" },
					{
						"El “1,000” sale agregando ceros con el resultado que nos dio, como en este caso fueron 3, se agregan 3 ceros al número divisor. Si fuera de milimetros a centimetros, nada más se agregaría un cero)",
						"Saludando",
					},
					{
						"para dar el resultado tendríamos que dividir 20mm entre 1,000 para que nos dé .02 m",
						"Saludando",
					},
					{ "El resultado es de .02 metros.", "Saludando" },
					{
						"Pero si queremos hacerlo de manera inversa tenemos que hacer el mismo procedimiento solo que ahora sería multiplicando y restando al revés, en vez de (mm - m) a (m - mm)",
						"Saludando",
					},
				},
				["Conversion de Masa"] = {
					{ "Primero tenemos que tener un orden de posición, que sería el siguiente.", "Saludando" },

					{ "1 = mg\n2 = cg\n3 = dg\n4 = g\n5 = dag\n6 = hg\n7 = kg", "Saludando" },
					{
						"Un ejemplo: \nSi el primer número es  10 gramos (g) y tenemos que convertirlo a metros (kg), lo que tenemos que hacer es usando la tabla anterior una resta entre 7 - 4 , donde el 7 significa que es kilogramos y el 4 que sería gramos.",
						"Saludando",
					},
					{ "En este caso nos da 3, ahora tenemos que dividir 10g entre 1,000", "Saludando" },
					{
						"El “1,000” sale agregando ceros con el resultado que nos dio, como en este caso fueron 3, se agregan 3 ceros al número divisor. Si fuera de hectogramos a kilogramos, nada más se agregaría un cero",
						"Saludando",
					},
					{
						"Para dar el resultado tendríamos que dividir 10g entre 1,000.\nEl resultado es de .02 gramos.",
						"Saludando",
					},
					{
						"Pero si queremos hacerlo de manera inversa tenemos que hacer el mismo procedimiento solo que ahora sería multiplicando y restando al revés, en vez de (g - kg) a (kg - g)",
						"Saludando",
					},
				},
				["Conversion de Temperatura"] = {
					{ "Primero tenemos que ver que significa cada Temperatura", "Saludando" },
					{
						"f = Fahrenheit \nk = Kelvins \nc = Celsius \n\nSe tiene que reemplazar las letras por el número que desees",
						"Saludando",
					},
					{
						"Kelvins:\n\nKelvins a Fahrenheit \nf = (k - 273.15) * 1.8 + 32\nKelvins a Celsius\n c = k - 273.15",
						"Saludando",
					},
					{
						"Celsius:\n\nCelsius a Kelvins k = c + 273.15\nCelsius a Fahrenheit\nf = (c * 1.8) + 32",
						"Saludando",
					},
					{
						"Fahrenheit:\n\nFahrenheit a Kelvins\nk = (f - 32) * 1.8 + 273.15\nFahrenheit  a Celsius\nc = (f - 32) * 1.8",
						"Saludando",
					},
				},
				["Conversion de Tiempo"] = {
					{
						"De segundos a minutos:\n\nDivide la cantidad de segundos entre 60 para obtener los minutos. El residuo serán los segundos restantes.",
						"Saludando",
					},
					{ "Minutos = Segundos / 60 Segundos restantes = Segundos % 60", "Saludando" },

					{
						"De minutos a horas:\n\nDivide la cantidad de minutos entre 60 para obtener las horas. El residuo serán los minutos restantes.",
						"Saludando",
					},
					{ "Horas = Minutos / 60 Minutos restantes = Minutos % 60", "Saludando" },
				},
				["Conversion Cuadrado/Cubico"] = {
					{
						"Usando el ejemplo de Longitud pero en caso del Cuadrado multiplicando por 20\n y por 30 usando el Cubico",
						"Saludando",
					},
				},
			},
			["Tutorial"] = {
				["¿Como sirve?"] = {
					{ "En la parte de arriba tienes diferentes tipos de numeros para convertir", "Saludando" },
					{
						"y a su lado izquierdo saldra diferentes tipos de medidas dependiendo que tipo uso",
						"Saludando",
					},
					{ "al dar click lo podra seleccionar para ponerlo en uno de los 2 cuadros grises", "Saludando" },
					{
						"el cuadro gris de arriba es el numero que quiere convertir y el de abajo es a que se va a convertir",
						"Saludando",
					},
					{ "ya al tener esto puede poner los datos en el recuadro blanco de la parte arriba", "Saludando" },
				},
				["Datos"] = {
					["¿Para que sirve convertir numeros?"] = {
						{ "En muchas cosas", "Saludando" },
						{ "en diferentes paises se usa una diferente manera de medir", "Saludando" },
						{
							"un ejemplo seria que en Estados Unidos se usa en la Temperatura los Fahrenheit.",
							"Saludando",
						},
						{ "Otras muy importantes son:", "Saludando" },
						{
							"Presentación de datos, Cálculos y comparaciones, Interacción con sistemas externos, Optimización de rendimiento, etc.",
							"Saludando",
						},
					},
				},
			},
		},
		["PlanoCartesiano"] = {
			["Operaciones"] = {
				["¿Como puedo saber la distancia entre dos puntos?"] = {
					{ "Tienes que tener la posición de ambos puntos", "Saludando" },
					{ "Las restas sus lados ejem:\n\n x2 - x1, donde su número es su respectivo punto ", "Saludando" },
					{ "x2 sería el eje y x1 el punto.", "Saludando" },
					{ "Y le pones un potencial al cuadrado quedaría:\n (x2 - x1)²", "Saludando" },
					{ "Hacemos lo mismo con su posición Y (y2 - y1)²", "Saludando" },
					{ "Ahora lo sumamos x + y", "Saludando" },
					{ "Y por último le sacamos el raíz √", "Saludando" },
				},
				["¿Como puedo saber cuantos grados tiene?"] = {
					{
						"Tienes que restar (x2 - x1) y (y2 - y1) donde el 2 es el eje y el 1 el punto",
						"Saludando",
					},
					{
						"Ahora usando tangente(y/x) y con el resultado ver dependiendo de la posicion si es positivo o negativo",
						"Saludando",
					},
				},
				["¿Como se que tipo de angulo tiene un plano?"] = {
					{
						'Si el punto se encuentra a la derecha del eje en un ángulo "Nulo / Completo" dependiendo del contexto',
						"Saludando",
					},
					{
						'"Nulo" si solo esta en el principio del Plano Cartesiano, "Completo" si ya dio la vuelta completa',
						"Saludando",
					},
					{
						'Si el punto se encuentra antes de los 90° y después de 0° será un ángulo "Agudo"',
						"Saludando",
					},
					{
						'Si el punto está arriba del eje que sería lo mismo a 90° será un ángulo "Recto"',
						"Saludando",
					},

					{
						'Si el punto está después de los 90° y antes de 180° es un ángulo "Obtuso',
						"Saludando",
					},
					{
						'Si el punto se encuentra a la izquierda que seria lo mismo a 180° seria un ángulo "Llano"',
						"Saludando",
					},
					{
						'Si los grados es mayor a 180° y menor a 360° seria un ángulo "Cóncavo"',
						"Saludando",
					},
				},
			},
		},
		["MovimientoRectilinio"] = {
			["Operaciones"] = {
				["Sacar datos con solo Velocidad Inicial"] = {
					{ "Datos para las formulas", "Saludando" },
					{ "d = Distancia\nvi = Velocidad Inicial\nt = Tiempo ", "Saludando" },
					{ "d = vit", "Saludando" },
				},
				["Sacar datos con Aceleración"] = {
					{ "Datos para las formulas", "Saludando" },
					{ "d = Distancia\nvi = Velocidad Inicial\nt = Tiempo\na = Aceleracion", "Saludando" },
					{ "d = vit + .5at²", "Saludando" },
					{ "v = vi + at", "Saludando" },
					{ "(Si no se tiene Velocidad Inicial se usa el numero 0)", "Saludando" },
				},
			},
			["General Movimiento"] = {
				["¿Cómo funciona la interfaz?"] = {
					{
						"A tu izquierda tienes las configuraciones para que el sistema sepa qué propiedades quieres que tenga",
						"Saludando",
					},
					{
						"A un lado tienes botones, el primero sirve para iniciar el objeto a un lado su botón de pausa",
						"Saludando",
					},
					{
						"Tienes flechas donde te indica que velocidad quieres que tenga el tiempo de ejecución",
						"Saludando",
					},
					{
						'Y por ultimo a tu derecha datos sobre ese mismo mecanismo, datos como "Tiempo Máximo"',
						"Saludando",
					},
				},
				["¿Cuales son los tipos de Configuraciones?"] = {
					{ "Existen tres tipos de configuraciones", "Saludando" },
					{
						'El "Primero" son datos que tienes que ponerlas sin ninguna excepción',
						"Saludando",
					},
					{ 'El "Secundario" tienes que elegir entre sus opciones para elegir solo uno', "Saludando" },
					{ 'El "Terciario" son datos opcionales  que no son vitales para el funcionamiento', "Saludando" },
				},
				["¿Cómo puedo cambiar el tiempo?"] = {
					{
						"Tienes que dar pausa y en los datos del experimento puedes mover su tiempo al que tu quieras",
						"Saludando",
					},
				},
			},
		},
		-- {"", "Saludando"},
		--\n

		["CaidaLibre"] = {
			["Operaciones"] = {
				["Sacar datos de movimiento"] = {
					{
						"Los datos de movimiento son los que se generan mediante el movimiento del objeto.",
						"Saludando",
					},
					{ "Datos importantes.", "Saludando" },
					{ "v = Velocidad\nh = Altura\nt = Tiempo", "Saludando" },
					{ "Datos extras serían:\ng = Gravedad", "Saludando" },
					{ "para sacar la velocidad se usa:", "Saludando" },
					{ "t = √2h / g", "Saludando" },
					{ "v = gt", "Saludando" },
					{ "h = gt² / 2", "Saludando" },
				},
				["Sacar datos de como se moverá"] = {
					{ 'Estos datos predicen alguno datos como "TiempoMaximo" o/y "TiempoSubida"', "Saludando" },
					{ "Datos para las formulas", "Saludando" },
					{ "g = Gravedad\n h = Altura", "Saludando" },
					{ "TiempoFinal = √2h / g", "Saludando" },
					{ "AlturaRecorrer = gTf² / 2\n(TiempoFinal = Tf)", "Saludando" },
				},
			},
			["General Movimiento"] = {
				["¿Cómo funciona la interfaz?"] = {
					{
						"A tu izquierda tienes las configuraciones para que el sistema sepa qué propiedades quieres que tenga",
						"Saludando",
					},
					{
						"A un lado tienes botones, el primero sirve para iniciar el objeto a un lado su botón de pausa",
						"Saludando",
					},
					{
						"Tienes flechas donde te indica que velocidad quieres que tenga el tiempo de ejecución",
						"Saludando",
					},
					{
						'Y por ultimo a tu derecha datos sobre ese mismo mecanismo, datos como "Tiempo Máximo"',
						"Saludando",
					},
				},
				["¿Cuales son los tipos de Configuraciones?"] = {
					{ "Existen tres tipos de configuraciones", "Saludando" },
					{
						'El "Primero" son datos que tienes que ponerlas sin ninguna excepción',
						"Saludando",
					},
					{ 'El "Secundario" tienes que elegir entre sus opciones para elegir solo uno', "Saludando" },
					{ 'El "Terciario" son datos opcionales  que no son vitales para el funcionamiento', "Saludando" },
				},
				["¿Cómo puedo cambiar el tiempo?"] = {
					{
						"Tienes que dar pausa y en los datos del experimento puedes mover su tiempo al que tu quieras",
						"Saludando",
					},
				},
			},
		},
		["TiroVertical"] = {
			["Operaciones"] = {
				["Sacar datos de movimiento"] = {
					{
						"Los datos de movimiento son los que se generan mediante el movimiento del objeto.",
						"Saludando",
					},
					{ "Datos para las formulas", "Saludando" },

					{ "g = Gravedad\nt = Tiempo\nvi = Velocidad Inicial\nv = Velocidad\nh = Altura", "Saludando" },
					{ "Altura = vit - (0.5 * g) * t²\n\nAltura = v² - vi² / (2 * -g)", "Saludando" },
					{ "Tiempo = vi - v / g", "Saludando" },
					{ "Velocidad = vi - gt", "Saludando" },
				},
				["Sacar datos de como se movera"] = {
					{ 'Estos datos predicen como alguno datos como "TiempoMaximo" o/y "TiempoSubida".', "Saludando" },
					{ "Datos para las formulas", "Saludando" },
					{ "g = Gravedad\nvi = Velocidad Inicial", "Saludando" },
					{ "TiempoSubida = vi/g", "Saludando" },
					{ "TiempoMaximo = TiempoSubida * 2", "Saludando" },
					{ "AlturaMaxima = vi²/2g", "Saludando" },
					{ "VelocidadFinal = vi - gvi/g *2 ", "Saludando" },
				},
			},
			["General Movimiento"] = {
				["¿Cómo funciona la interfaz?"] = {
					{
						"A tu izquierda tienes las configuraciones para que el sistema sepa qué propiedades quieres que tenga",
						"Saludando",
					},
					{
						"A un lado tienes botones, el primero sirve para iniciar el objeto a un lado su botón de pausa",
						"Saludando",
					},
					{
						"Tienes flechas donde te indica que velocidad quieres que tenga el tiempo de ejecución",
						"Saludando",
					},
					{
						'Y por ultimo a tu derecha datos sobre ese mismo mecanismo, datos como "Tiempo Máximo"',
						"Saludando",
					},
				},
				["¿Cuales son los tipos de Configuraciones?"] = {
					{ "Existen tres tipos de configuraciones", "Saludando" },
					{
						'El "Primero" son datos que tienes que ponerlas sin ninguna excepción',
						"Saludando",
					},
					{ 'El "Secundario" tienes que elegir entre sus opciones para elegir solo uno', "Saludando" },
					{ 'El "Terciario" son datos opcionales  que no son vitales para el funcionamiento', "Saludando" },
				},
				["¿Cómo puedo cambiar el tiempo?"] = {
					{
						"Tienes que dar pausa y en los datos del experimento puedes mover su tiempo al que tu quieras",
						"Saludando",
					},
				},
			},
		},
		["TiroParabolico"] = {
			["Operaciones"] = {
				["Sacar datos de movimiento"] = {
					{ "Los datos de movimiento son los que se generan mediante el movimiento del objeto", "Saludando" },
					{ "Datos para las formulas", "Saludando" },
					{ "g = Gravedad\nt = Tiempo\nvi = VelocidadInicial\ngra = Grados\ndis = Distancia", "Saludando" },
					{
						"Velocidad Horizontal (vx) = vi * cos(gra), ,\nVelocidad Vertical (vy) = vi * sin(gra),\n (Todos los calculos fueron hechos con radianes.) (vy)",
						"Saludando",
					},
					{ "Posicion Horizontal = vxt", "Saludando" },
					{ "Posicion Vertical = vyt - .5gt²", "Saludando" },
					{ "VelocidadInicial = √(-.5gt)² / sin(gra)²", "Saludando" },
					{ "VelocidadInicial = √dis * g/ sin(2 * gra)", "Saludando" },
				},
				["Sacar datos de como se movera"] = {
					{ 'Estos datos predicen como alguno datos como "TiempoMaximo" o/y "TiempoSubida"', "Saludando" },
					{ "Datos para las formulas", "Saludando" },
					{ "g = Gravedad\ngra = Grados\nvi = VelocidadInicial", "Saludando" },
					{
						"Velocidad Horizontal (vx) = vi * cos(gra), ,\nVelocidad Vertical (vy) = vi * sin(gra),\n (Todos los calculos fueron hechos con radianes.) (vy)",
						"Saludando",
					},
					{ "TiempoSubida = vy/g", "Saludando" },
					{ "AlturaMaxima = vy²/2g", "Saludando" },
					{ "TiempoMaximo = 2vy / g", "Saludando" },
					{ "AlcanceHorizontal = vx(vy/2g)", "Saludando" },
				},
			},
			["General Movimiento"] = {
				["¿Cómo funciona la interfaz?"] = {
					{
						"A tu izquierda tienes las configuraciones para que el sistema sepa qué propiedades quieres que tenga",
						"Saludando",
					},
					{
						"A un lado tienes botones, el primero sirve para iniciar el objeto a un lado su botón de pausa",
						"Saludando",
					},
					{
						"Tienes flechas donde te indica que velocidad quieres que tenga el tiempo de ejecución",
						"Saludando",
					},
					{
						'Y por ultimo a tu derecha datos sobre ese mismo mecanismo, datos como "Tiempo Máximo"',
						"Saludando",
					},
				},
				["¿Cuales son los tipos de Configuraciones?"] = {
					{ "Existen tres tipos de configuraciones", "Saludando" },
					{
						'El "Primero" son datos que tienes que ponerlas sin ninguna excepción',
						"Saludando",
					},
					{ 'El "Secundario" tienes que elegir entre sus opciones para elegir solo uno', "Saludando" },
					{ 'El "Terciario" son datos opcionales  que no son vitales para el funcionamiento', "Saludando" },
				},
				["¿Cómo puedo cambiar el tiempo?"] = {
					{
						"Tienes que dar pausa y en los datos del experimento puedes mover su tiempo al que tu quieras",
						"Saludando",
					},
				},
			},
		},
	},
}

return module
