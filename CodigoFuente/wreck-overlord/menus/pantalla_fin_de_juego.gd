extends Control

@onready var button_play = $Botonplay
@onready var background1 = $Fondo1
@onready var background2 = $Fondo2
@onready var points1 = $P1Puntos
@onready var points2 = $P2Puntos
@onready var coop_points = $PuntosCoop
@onready var coop_points_label = $PuntosCoopLabel
@onready var trophy1 = $TrofeoP1
@onready var trophy2 = $TrofeoP2
@onready var car_anim_p1 = $Auto_P1
@onready var car_anim_p2 = $Auto_P2
@onready var puntaje_ganador = 0

func _ready():
	add_to_group("traduccion_dependiente")
	actualizar_textos()
	if not Global.Music.playing:
		Global.Music.play()
	$Botonplay.grab_focus()
	$Botonplay.connect("pressed", Callable(self, "_on_play_pressed"))
	if Global.selected_mode == 1:
		background2.visible = false
		coop_points.visible = false
		coop_points_label.visible = false
		points2.text = str(Global.score1)
		points1.text = str(Global.score2)
		if Global.score1 <= Global.score2:
			trophy1.visible = true
			puntaje_ganador = Global.score2
		if Global.score2 <= Global.score1:
			trophy2.visible = true
			puntaje_ganador = Global.score1
			
		var user_id : String = Firebase.Auth.auth.localid
		
		var http = HTTPRequest.new()
		add_child(http)
		http.request_completed.connect(_on_completed)
		var url = "https://firestore.googleapis.com/v1/projects/wreck-overlord-c37c4/databases/(default)/documents/puntajes"
		var headers = ["Content-Type: application/json"]
		var body = {
			"fields": {
				"nombre": {"stringValue": user_id},
				"puntos": {"integerValue": str(puntaje_ganador)}
			}
		}
		var json_body = JSON.stringify(body)
		
		http.request(url, headers, HTTPClient.METHOD_POST, json_body)
		
	if Global.selected_mode == 2:
		background1.visible = false
		points1.visible = false
		points2.visible = false
		coop_points.text = str(Global.score1)
	car_anim_p1.play(str(Global.player1_selceted_car))
	car_anim_p2.play(str(Global.player2_selceted_car))

func _physics_process(_delta):
	await get_tree().create_timer(1.2).timeout
	get_input()

func get_input():
	var accept := "shoot1"
	if Input.is_action_just_pressed(accept):
		queue_free()
		if Global.selected_mode == 1:
			get_tree().change_scene_to_file("res://menus/pantalla_ranking.tscn")
		else:
			get_tree().change_scene_to_file("res://menus/modosdejuego.tscn")

func _on_play_pressed():
	queue_free()
	if Global.selected_mode == 1:
		get_tree().change_scene_to_file("res://menus/pantalla_ranking.tscn")
	else:
		get_tree().change_scene_to_file("res://menus/modosdejuego.tscn")
	
func _on_completed(result, response_code, headers, body):
		print("Respuesta:", body.get_string_from_utf8())
		
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if button_play.has_focus():
			button_play.emit_signal("pressed")

func actualizar_textos():
	$PuntosCoopLabel.text = Global.t("Muertes:")
	$Player1.text = Global.t("Jugador 1")
	$Player2.text = Global.t("Jugador 2")
