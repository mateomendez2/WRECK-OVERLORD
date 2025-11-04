extends ProgressBar

@onready var timer = $Timer
@onready var barradanio = $DamageBar


var life = 0 : set = set_life


func set_life(new_life):
	var previous_life = life
	life = min(max_value, new_life)
	value = life
	if life < previous_life:
		timer.start()
	else:
		barradanio.value = life

func vida_inicial(_vida):
	life = _vida
	max_value = life
	value = life
	barradanio.max_value = life
	barradanio.value = life
	

func _on_timer_timeout() -> void:
	barradanio.value = life
