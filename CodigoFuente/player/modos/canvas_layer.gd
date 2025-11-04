extends CanvasLayer

@onready var timer_label = $Tiempo
@onready var game_timer = $MatchTimer
@onready var death_counter = $ContadorMuertes

var total_time = 120

func _ready() -> void:
	if Global.selected_mode == 1:
		death_counter.visible = false
	update_label()
	game_timer.start()

func _physics_process(_delta):
	update_label()

func _on_match_timer_timeout() -> void:
	if total_time > 0:
		total_time -= 1
	else:
		game_timer.stop()

func update_label():
	var minutes = total_time / 60
	var seconds = total_time % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
	death_counter.text = str(Global.score1)
