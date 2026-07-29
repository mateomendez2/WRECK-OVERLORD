extends Control

@onready var idioma = 1
@onready var flecha = $Flecha

func _ready():
	if not Global.Music.playing:
		Global.Music.play()

func _physics_process(_delta):
	get_input()

func get_input():
	
	var p1_rigth = "steer_right1"
	var p1_left = "steer_left1"
	var p1_accept = "shoot1"
	
	if Input.is_action_just_pressed(p1_rigth) and idioma < 3:
		idioma += 1
		update_flecha()
	
	if Input.is_action_just_pressed(p1_left) and idioma > 1:
		idioma -= 1
		update_flecha()
	
	if Input.is_action_just_pressed(p1_accept):
		var codigos = {1: "es", 2: "en", 3: "pt"} # Ejemplo
		Global.cambiar_idioma(codigos[idioma])
		$Timer.start()

func update_flecha():
	if idioma == 1:
		flecha.position.x = 435
	elif idioma == 2:
		flecha.position.x = 960
	elif idioma == 3:
		flecha.position.x = 1485


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://menus/pantallacontroles.tscn")
