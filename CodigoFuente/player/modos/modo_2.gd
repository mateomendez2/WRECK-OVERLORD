extends Node2D

var BombaScene = preload("res://bomba/bomba.tscn")

@onready var Mapa1 = $Mapa1
@onready var Mapa2 = $Mapa2
@onready var Mapa3 = $Mapa3
@onready var timerbomba = $TimerBomba
@onready var explosion_sound = $Explosion1
@onready var timer_sound = $TimerSonido
@onready var Player1 = $Player1
@onready var Player2 = $Player2

var bomba_x = 0
var bomba_y = 0
var cantidad_bombas = 3
var selected_map = 3 # randi_range(1, 3)

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

func _on_timer_bomba_timeout() -> void:
	for i in range (cantidad_bombas):
		if selected_map == 3:
			bomba_x = randi_range(300, 1600)
		else:
			bomba_x = randi_range(130, 1800)
		bomba_y = randi_range(130, 905)
		var bomba = BombaScene.instantiate()
		bomba.global_position = Vector2(bomba_x, bomba_y)
		add_child(bomba)
	cantidad_bombas += 1
	timer_sound.start()

func _on_timer_partida_timeout() -> void:
	queue_free()
	get_tree().change_scene_to_file("res://menus/pantalla_fin_de_juego.tscn")

func _on_timer_sonido_timeout() -> void:
	explosion_sound.play()
