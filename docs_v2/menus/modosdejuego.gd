extends Control

@onready var sprite1 = $Sprite2D
@onready var sprite2 = $Sprite2D2

var chosed_mode = 1

func _ready():
	Global.score1 = 0
	Global.score2 = 0
	$Modo1.connect("pressed", Callable(self, "_on_modo1_pressed"))
	$Modo2.connect("pressed", Callable(self, "_on_modo2_pressed"))
	if not Global.Music.playing:
		Global.Music.play()

func _physics_process(_delta):
	get_input()

func _on_modo1_pressed():
	chosed_mode = 1
	abrir_pantalla_autos()

func _on_modo2_pressed():
	chosed_mode = 2
	abrir_pantalla_autos()

func get_input():
	var accept := "shoot1"
	var mode1 := "steer_left1"
	var mode2 := "steer_right1"

	if Input.is_action_pressed(mode1):
		chosed_mode = 1
		sprite1.visible = true
		sprite2.visible = false

	if Input.is_action_pressed(mode2):
		chosed_mode = 2
		sprite2.visible = true
		sprite1.visible = false

	if Input.is_action_just_pressed(accept):
		abrir_pantalla_autos()

func abrir_pantalla_autos():
	Global.selected_mode = chosed_mode
	queue_free()
	get_tree().change_scene_to_file("res://menus/pantallaautos.tscn")
