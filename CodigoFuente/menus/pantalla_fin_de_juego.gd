extends Control

@onready var button_play = $Botonplay
@onready var background1 = $Fondo1
@onready var background2 = $Fondo2
@onready var points1 = $P1Puntos
@onready var points2 = $P2Puntos
@onready var coop_points = $PuntosCoop
@onready var trophy1 = $TrofeoP1
@onready var trophy2 = $TrofeoP2
@onready var car_anim_p1 = $Auto_P1
@onready var car_anim_p2 = $Auto_P2

func _ready():
	if not Global.Music.playing:
		Global.Music.play()
	$Botonplay.grab_focus()
	$Botonplay.connect("pressed", Callable(self, "_on_play_pressed"))
	if Global.selected_mode == 1:
		background2.visible = false
		coop_points.visible = false
		points2.text = str(Global.score1)
		points1.text = str(Global.score2)
		if Global.score1 <= Global.score2:
			trophy1.visible = true
		if Global.score2 <= Global.score1:
			trophy2.visible = true
	if Global.selected_mode == 2:
		background1.visible = false
		points1.visible = false
		points2.visible = false
		coop_points.text = str(Global.score1)
	car_anim_p1.play(str(Global.player1_selceted_car))
	car_anim_p2.play(str(Global.player2_selceted_car))

func _physics_process(_delta):
	get_input()

func get_input():
	var accept := "shoot1"
	if Input.is_action_just_pressed(accept):
		queue_free()
		get_tree().change_scene_to_file("res://menus/modosdejuego.tscn")

func _on_play_pressed():
	queue_free()
	get_tree().change_scene_to_file("res://menus/modosdejuego.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if button_play.has_focus():
			button_play.emit_signal("pressed")
