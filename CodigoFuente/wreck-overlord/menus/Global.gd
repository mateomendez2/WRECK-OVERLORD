extends Node

var idioma_actual : String = "es"
var selected_mode = 1
var score1 = 0
var score2 = 0
var player1_selceted_car = 0
var player2_selceted_car = 0
var p1_respawn_position = 0
var p2_respawn_position = 0
var traducciones = {} 
var url_api = "https://traducila.vercel.app/api/translations/"
var project_id = "4072413c-a2c6-4827-b371-5e4d1394b9cb"
@onready var http_request = $HTTPRequest
@onready var Music = $MenuMusic

func _ready():
	if not Music.playing:
		Music.play()
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

func cambiar_idioma(codigo_idioma):
	idioma_actual = codigo_idioma
	var url_completa = url_api + project_id + "/" + codigo_idioma
	http_request.request(url_completa)

func _on_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		var json = JSON.new()
		if json.parse(body.get_string_from_utf8()) == OK:
			procesar_traducciones(json.data)
	else:
		print("Error en API Traducila: ", response_code)

func procesar_traducciones(datos):
	traducciones.clear()
	if datos.has("data") and datos["data"].has("words"):
		for item in datos["data"]["words"]:
			traducciones[item["key"]] = item["translate"]
		print("Traducciones Globales Cargadas")
		# Opcional: Avisar a las escenas activas que el idioma cambió
		get_tree().call_group("traduccion_dependiente", "actualizar_textos")

func t(clave):
	return traducciones.get(clave, clave)
