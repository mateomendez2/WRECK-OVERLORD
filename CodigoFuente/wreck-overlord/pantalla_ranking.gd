extends Node

@onready var contenedor = $VBoxContainer

var url = "https://firestore.googleapis.com/v1/projects/wreck-overlord-c37c4/databases/(default)/documents/puntajes"
func _ready():
	obtener_puntajes()

func obtener_puntajes():
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_request_completed)
	http.request(url)

func _on_request_completed(_result, _response_code, _headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())

	if data == null or not data.has("documents"):
		print("No hay datos")
		return

	var lista = []

	for doc in data["documents"]:
		var fields = doc["fields"]

		var nombre = fields["nombre"]["stringValue"]
		var puntos = int(fields["puntos"]["integerValue"])

		lista.append({
			"nombre": nombre,
			"puntos": puntos
		})

	# ordenar de mayor a menor
	lista.sort_custom(func(a, b): return a["puntos"] > b["puntos"])

	# tomar top 10
	var top10 = lista.slice(0, min(10, lista.size()))

	mostrar_ranking(top10)

func mostrar_ranking(top):
	# limpiar anteriores
	for child in contenedor.get_children():
		child.queue_free()

	var pos = 1

	for jugador in top:
		var label = Label.new()
		label.text = str(pos) + ". " + jugador["nombre"] + " - " + str(jugador["puntos"])
		label.add_theme_color_override("font_color", Color.BLACK)
		label.add_theme_font_size_override("font_size", 30)
		contenedor.add_child(label)
		pos += 1

func _physics_process(_delta):
	await get_tree().create_timer(1.2).timeout
	get_input()

func get_input():
	var accept := "shoot1"
	if Input.is_action_just_pressed(accept):
		queue_free()
		get_tree().change_scene_to_file("res://menus/modosdejuego.tscn")

func _on_play_pressed():
	queue_free()
	get_tree().change_scene_to_file("res://menus/modosdejuego.tscn")
