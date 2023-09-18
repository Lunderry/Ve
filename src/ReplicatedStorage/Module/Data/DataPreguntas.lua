return {
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
		{ "Hola!, ¿Que tema quieres ver?", "Saludando" },
	},
	["Despedida"] = {
		{ "Adios aqui estare esperando", "Saludando" },
	},

	--Sin eleccion
	[""] = {},
	["ConversionUnidades"] = {
		["¿Para que convertir unidades?"] = {
			{
				"Podemos decir que la conversiones de unidades sirven para relacionar diferentes sistemas métricos",
				"Escribiendo",
			},
			{ " Y con ello lograr un vinculo en las magnitude", "Escribiendo" },
			{
				"Como por ejemplo los Fahrenheit se usan en diferentes paises y no sabremos relacionarlo de buena manera",
				"Escribiendo",
			},
			{ "Si no fuese por el conversor no podriamos saber nuestras necesidades", "Escribiendo" },
		},
		["Unidad principal a la que se desea convertir"] = {
			["La Longitud"] = { { "m (Metros)", "Saludando" } },
			["La Masa"] = { { "g (Gramos)", "Saludando" } },
			["La Temperatura"] = { { "°C (Centigrados)", "Saludando" } },
			["El Tiempo"] = { { "seg (Segundos)", "Saludando" } },
			["La Area"] = { { "m² (Metro cuadrado)", "Saludando" } },
			["El Volumen"] = { { "m³ (Metro cubico)", "Saludando" } },
			["La Velocidad"] = { { "m/seg (Metro sobre segundo)", "Saludando" } },
			["La Aceleracion"] = { { "m/seg² (Metro sobre segundo cuadrado)", "Saludando" } },
			["Las Calorias"] = { { "Cal (Calorias)", "Saludando" } },
		},
		-- ["¿Por qué usar este Conversor de Unidades a las demás?"] = {
		-- 	{ "Lo que se busca en este conversor no es darte resultados, si no aprender en como resolverlo", "Saludando" },
		-- 	{ "Hay muchos conversores para resolver unidades pero ninguno te explica de ", "Saludando" },

		-- },
	},
	["PlanoCartesiano"] = {
		["¿Como sacar el datos..?"] = {
			["Distancia entre dos puntos"] = {
				{ "Para resolverlo tenemos que usar esta operacion.", "Saludando", "√(x2 - x1)² + (y2 - y1)²" },
				{ "Para uso de la calculadora.", "Saludando", "√((x2 - x1)² + (y2 - y1)²)", "Saludando" },
				{ "Para hacer esto tenemos que tener en cuenta la posicion x / y del eje y el vertice", "Saludando" },
				{ "Tomemos de ejemplo: \n vertice = (2x, 5y) \n eje = (10x, 3y) ", "Saludando" },
				{
					"Ahora se resta la posicion x/ y. \n (el 2 simboliza la posicion del eje y el 1 del vertice) ",
					"Saludando",
					"(x2 - x1), (y2 - y1)",
				},
				{ "Resuelto con los numeros planteados:", "Saludando", "√(8)² + (- 2)²" },
				{ "Con eso resuelto lo elevamos al cuadrado", "Saludando", "√ x² + y²" },
				{ "Resuelto con los numeros planteados:", "Saludando", "√ 64 + 4" },
				{ "Lo sumamos", "Saludando", "√ 68" },
				{ "Ahora usamos la raiz redondeado y quedara", "Saludando", "8.2462" },
			},
			--
			["Los grados"] = {
				{ "Primero tenemos que saber la posicion x/y del veritce y del eje", "Saludando" },
				{ "Usemos estas posiciones de ejemplo:\n Vetice = (2x, 5y)\n Eje = (10x, 3y)" },
				{
					"Ahora restarlos\n (2 = posicion del eje, 1 = posicion del vertice)",
					"Saludando",
					"(x2 - x1), (y2 - y1)",
				},
				{ "Con las posiciones establecidas quedaran así", "Saludando", "(10 - 2), (3 - 5)" },
				{ "Respondido daria:", "Saludando", "(8), (-2)" },
				{
					"Ahora se usa tan-1 con radianes\n (Esta operacion no se puede hacer en la calculadora)",
					"Saludando",
					"[tan-1(y/x)]",
				},
				{ "Con las poscisiones establecidas seria:", "Saludando", "[tan-1(-4]" },
				{ "Y usando el tan-1 seria:", "Saludando", "-1.32581766°" },
			},
			["Tipo de angulo"] = {
				{
					'Primero tenemos que saber que grados tiene podemos haciendolo con la operacion que se explica en "Los grados"',
					"Saludando",
				},
				{ 'Si angulo es igual a 0° es un angulo "Nulo"', "Saludando" },
				{ 'Si el angulo tiene 360° es un angulo "Completo"', "Saludando" },
				{
					"(En la prueba se muestra ambas ya que no se sabe si dio la vuelta o esta empezando ya que equivale lo mismo)",
					"Saludando",
				},
				{ 'Si el angulo es mayor 0° y menor a 90° es un angulo "Agudo"', "Saludando" },
				{ 'Si el angulo tiene exactamente 90° es un angulo "Recto"', "Saludando" },
				{ 'Si el angulo es mayor a 90° y menor a 180° es un angulo "Obusto"', "Saludando" },
				{ 'Si el angulo tiene exactamente 180° es un angulo "Llano"', "Saludando" },
				{ 'Si el angulo es mayor a 180° y menor a 360° es un angulo "Concavo"', "Saludando" },
			},
		},
		["¿Para que sirve el plano cartesiano?"] = {
			{
				"Tiene varios usos pero aquí se usa principalmente el uso de fisica e incluso un poco de matematicas",
				"Saludando",
			},
			{
				"Se usa para: Representar puntos, Graficacion de funciones matematicas, Ingenieria y diseño, etc.",
				"Saludando",
			},
			{
				"Pero nosotros lo usamos para enseñar como son los movimientos de objetos de dos dimensiones",
				"Saludando",
			},
		},
		["¿Como saber cuando la posicion es positiva o negativa?"] = {
			{
				"Para este caso podemos usar el eje (punto medio), ejeX (linea horizontal) y ejeY (linea vertical) de color rojo, para ver si es positivo o negativo",
				"Saludando",
			},
			{
				"Si el objeto se encuentra mas a la derecha del eje la posicion X es positiva de lo contrario es negativo si se encuentra en la misma posicion de la linea vertical es 0",
				"Saludando",
			},
			{
				"Si el objeto se encuentra mas a la arriba del eje la posicion Y es positiva de lo contrario es negativo si se encuentra en la misma posicion de la linea horizontal es 0",
				"Saludando",
			},
		},
		["¿Que contiene un plano cartesiano?"] = {
			{
				"Punto de origen:\nEste es el centro del plano cartesiano se usa de referencia su posicion es(0x, 0y)\n(Es el punto negro del plano)",
				"Saludando",
			},
			{ "Eje:\nEste tiene un ejeX (eje horizontal) y ejeY (eje vertical)\n(Es el punto de azul)", "Saludando" },
			{
				"Cuadrantes:\nEstos son las partes positivas o negativas de las posiciones x/y\n(Son los cuadros grises que estan a los lados del eje)",
				"Saludando",
			},
			{
				"Cordenadas:\nCada punto representa las cordenas de numeros\n(Son todos los cuadros grises)",
				"Saludando",
			},
			{ "Uniades de medida:\nEste esta etiquetado con unidades de medida de los ejes", "Saludando" },
			{ "Este ultimo no se encuentra en el plano pero si en los movimientos", "Saludando" },
		},
	},
	["Calculadora"] = {
		["¿Que tipo de calculadora es?"] = {
			{ 'Es una calculadora de "Expresion Ambigua"', "Saludando" },
			{
				"Esto significa que algunos calculos se tengan que escribir diferente para dar un resultado especifico como:",
				"Saludando",
				"8/2(2 + 2)",
			},
			{ "Esto hace que en una expresion de precedencia de operadores de el resultado:", "Saludando", "1" },
			{ "Mientras tanto en una calculadora de expresión ambigua de el resultado:", "Saludando", "16" },
			{
				"Ya que lo que hace es resolver el parentesis y despues seguir con la operacion de izquierda a derecha siguiendo la jerarquia de operaciones:",
				"Saludando",
				"8/2(4)",
			},
			{ "Así provocando que de:", "Saludando", "4(4) = 16" },
			{
				"Mientras tanto la expresión de precedencia de operadores se resuelve el parentesis y con eso se mutlplica con el numero anterior",
				"Saludando",
				"8 / 2(4)",
			},
			{ "Así dando:", "Saludando", "8/8 = 1" },
			{
				"Para remediar esto tienes que plantear la operacion diferente usando parentesis:",
				"Saludando",
				"(8/(2(2 + 2)) = 1",
			},
		},
		["Jerarquia de operaciones"] = {
			{ "El primero en resolverse es el parentesis, y la tigonometria", "Saludando", "(), [cos()]" },
			{ "Despues sigue la potencia y las raizes", "Saludando", "^, ², √" },
			{ "Despues sigue la multiplicación y divisior", "Saludando", "*, /" },
			{ "Y por ultimo queda la suma y restas", "Saludando", "+, -" },
			{
				"1.- Parentesis y trigonometria,\n 2.- Potencia y raices,\n 3.- Multiplicacion y divisor,\n 4.- Suma y Resta",
				"Saludando",
			},
		},
		["Reglas de operaciones"] = {
			{ "Tienes que resolver primero los parentesis y la trigonometria", "Saludando" },
			{
				"En caso de los parentesis, tomalo en cuenta como una operacion dentro de otra ya que a la hora de resolverlo tienes que seguir la jerarquia desde el principio",
				"Saludando",
			},
			{
				"Así que si tiene otro parentesis dentro de el se tiene que resolver primero",
				"Saludando",
				"(2 + 2 (5 + 1))",
			},
			{ "Ejemplo de como quedaria el primer procedimiento", "Saludando", "(2 + 2(6))" },
			{
				"Y la trigonometria seria igual solo que al terminar la operacion lo convertimos al tipo trigonometrico requerido",
				"Saludando",
			},
			{
				'Ejemplo:\n (No es necesario usar los corchetes "[]", solo es ejemplo para copiar)',
				"Saludando",
				"[cos(2 + 13)]",
			},
			{ "Usando rad para resolverlo:", "Saludando", "[cos(15)] = (-0.759)" },
			{
				"Despues de esto se resuelve de izquierda a derecha siguiendo la jerarquia de numeros\n (Esto depende de la calculadora en caso de esta al ser ambigua se hace de esta manera)",
				"Saludando",
			},
			{ "Ejemplo:", "Saludando", "2 * 3 + (5 ^ 2)" },
			{ "Resolver primero el parentesis", "Saludando", "2 * 3 + (10)" },
			{ "Al no tener potencias sigue la multiplicaion y división", "Saludando", "6 + 10 " },
			{ "Dando:", "Saludando", "16" },
		},
		["¿Como funciona y para que es el conversor en la calculadora?"] = {
			{ "Sirve para entender que las variables no siempre tendran la misma unidad", "Saludando" },
			{
				'Lo primero que hace es convertirlos a una unidad principal, usando "{}" y dentro de el poner la unidad que quieres convertir',
				"Saludando",
				"2{yd} + 1{min}",
			},
			{ "Ahora se pone en su unidad estandar, en este caso es m y seg", "Saludando" },
			{ "Con las unidades cambiada sería:", "Saludando", "1.828{m} + 60{seg} " },
			{ "Resuelto seria:", "Saludando", "61.829F" },
		},
	},
	["MovimientoRectilinio"] = {
		["Sacar datos de movimiento"] = {
			["Sin Aceleracion"] = {
				["Distancia"] = {
					{ "Tienes que tener los siguientes datos:", "Saludando" },
					{ "Vi = Velocidad Inicial,\n t = Tiempo.", "Saludando" },
					{ "Distancia:", "Saludando", "vit" },
					{ "Distancia calculadora:", "Saludando", "vi * t" },
				},
				["Velocidad"] = {
					{ "Tienes que tener los siguientes datos:", "Saludando" },
					{ "Vi = Velocidad Inicial,\n t = Tiempo.", "Saludando" },
					{ "Velocidad:", "Saludando", "d / t" },
				},
			},
			["Con Aceleracion"] = {
				["Distancia"] = {
					{ "Tienes que tener los siguientes datos:", "Saludando" },
					{ "Vi = Velocidad Inicial,\n a = Aceleración,\n t = Tiempo.", "Saludando" },
					{ "Distancia:", "Saludando", "vit + (1/2 at²" },
					{ "Distancia calculadora:", "Saludando", "(vi * t) + ((.5 * a) * (t ^ 2))" },
				},
				["Velocidad"] = {
					{ "Tienes que tener los siguientes datos:", "Saludando" },
					{ "Vi = Velocidad Inicial,\n a = Aceleración,\n t = Tiempo.", "Saludando" },
					{ "Velocidad:", "Saludando", "vi + at" },
					{ "Velocidad calculadora:", "Saludando", "vi + (a * t)" },
				},
			},
		},
		["Sacar datos de como se movera"] = {
			["Tiempo Maximo"] = {
				{ "Tenemos que saber si tiene un aceleracion positiva o negativa", "Saludando" },
				{ "Si es positiva el Tiempo Maximo es infinito", "Saludando" },
				{ "De lo contrario seria:", "Saludando" }, --poner operacion
			},
		},
		["Principios fisicos que se usan"] = {},
		["Datos Curiosos"] = {},
	},
	-- {"", "Saludando"},
	--\n

	["CaidaLibre"] = {
		["Sacar datos de movimiento"] = {
			["Velocidad Final"] = {},
			["Altura"] = {},
			["Tiempo dependiendo de la altura"] = {},
			-- vf = (g * t)
			-- h = ((g * (t ^ 2)) / 2)
			-- t = math.sqrt((2 * h) / g)
		},
		["Sacar datos de como se movera"] = {
			["TiempoMaximo"] = {}, --math.sqrt((2 * h) / g)
			["Altura que recorrera"] = {}, --g * ((tiempoFinal ^ 2) / 2)
		},
		["Principios fisicos que se usan"] = {},
		["Datos Curiosos"] = {},

		--
	},
	["TiroVertical"] = {
		["Sacar datos de movimiento"] = {
			["Con tiempo"] = {
				["VelocidadInicial"] = {}, -- h = (vi * t) - (0.5 * g) * (t ^ 2)
				["Velocidad"] = {}, -- v = vi - (g * t)
				["Altura"] = {}, -- h = (vi * t) - (0.5 * g) * (t ^ 2)
			},
			["Con velocidad"] = {
				["Altura"] = {}, -- h = ((v ^ 2) - (vi ^ 2)) / (2 * -g)
				["Tiempo"] = {}, -- t = (vi - v) / g
			},
		},
		["Sacar datos de como se movera"] = {
			["Tiempo Maximo"] = {}, --Tsubida * 2
			["Altura Maxima"] = {}, --  (vi ^ 2) / (2 * g),
			["Tiempo de Subida"] = {}, -- vi / g,
			["Velocidad Final"] = {}, --vi - (g * ((vi / g) * 2)),
		},
		["Principios fisicos que se usan"] = {},
		["Datos Curiosos"] = {},
		--
	},
	["TiroParabolico"] = {
		["Sacar datos de movimiento"] = {
			["Velocidad"] = {
				["Velocidad X"] = {}, --vi * math.cos(graRad)(rad)
				["Velocidad Y"] = {}, -- (vi * math.sin(graRad)) - (g * t),
			},
			["Posicion"] = {
				["Posicion X"] = {}, --vi * math.cos(graRad)(rad) -- x = vx * t
				["Posicion Y"] = {}, --  vi * math.sin(graRad)(rad) --y = (vy * t) - (0.5 * g * t ^ 2)
			},
			["Tener la velocidad inicial para que tenga..."] = {
				["Un Tiempo establecido"] = {}, --vi =  math.sqrt((-0.5 * g * t) ^ 2 / math.sin(graRad) ^ 2)
				["Una Distacia establecida"] = {}, --vi = math.sqrt((-0.5 * g * t) ^ 2 / math.sin(graRad) ^ 2)
			},
		},
		["Sacar datos de como se movera"] = {
			["Tiempo Maximo"] = {}, -- (2 * (vi * math.sin(graRad))) / g
			["Altura Maxima"] = {}, --vy ^ 2) / (2 * g),
			["Tiempo Subida"] = {}, --(vi * math.sin(graRad)) / g
			["Alcance Horizontal"] = {}, -- -(vx * (vy / g * 2)),
		},
		["Principios fisicos que se usan"] = {},
		["Datos Curiosos"] = {},
		--
	},
}
