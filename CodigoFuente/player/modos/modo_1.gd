extends Node2D

@onready var Mapa1 = $Mapa1
@onready var Mapa2 = $Mapa2
@onready var Mapa3 = $Mapa3
@onready var Player1 = $Player1
@onready var Player2 = $Player2

var selected_map = randi_range(1, 3)

func _ready():
	Global.p1_respawn_position = 200
	Global.p2_respawn_position = 1700
	
	randomize()
	
	if selected_map == 1:
		Mapa2.queue_free()
		Mapa3.queue_free()
		
	if selected_map == 2:
		Mapa1.queue_free()
		Mapa3.queue_free()
		
	if selected_map == 3:
		Mapa1.queue_free()
		Mapa2.queue_free()
		Global.p1_respawn_position = 400
		Global.p2_respawn_position = 1500
	
	Player1.global_position.x = Global.p1_respawn_position
	Player2.global_position.x = Global.p2_respawn_position

func _on_timer_partida_timeout() -> void:
	queue_free()
	get_tree().change_scene_to_file("res://menus/pantalla_fin_de_juego.tscn")
