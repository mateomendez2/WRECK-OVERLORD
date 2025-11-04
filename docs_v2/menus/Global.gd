extends Node

var selected_mode = 1
var score1 = 0
var score2 = 0
var player1_selceted_car = 0
var player2_selceted_car = 0
var p1_respawn_position = 0
var p2_respawn_position = 0
@onready var Music = $MenuMusic

func _ready():
	if not Music.playing:
		Music.play()
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
