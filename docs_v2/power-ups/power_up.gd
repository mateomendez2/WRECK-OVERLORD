extends Area2D

var is_active: bool = false
var salected_power_up = 1
@onready var speed_sprite = $PowerUpSpeed
@onready var heal_sprite = $PowerUpHeal
@onready var laser_sprite = $PowerUpLaser
@onready var off_sprite = $PowerUpOff
@onready var respawn_timer = $PowerUpRespawnTimer

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if is_active == false:
		return

	if body.is_in_group("Player"):

		is_active = false
		_update_sprites()
		respawn_timer.start()
		if salected_power_up == 1:
			if body.has_method("super_speed"):
				body.super_speed()

		if salected_power_up == 2:
			if body.has_method("take_damage"):
				body.take_damage(-40)

		if salected_power_up == 3:
			if body.has_method("laser_time"):
				body.laser_time()

func _update_sprites():
	if is_active == false:
		heal_sprite.visible = false
		laser_sprite.visible = false
		speed_sprite.visible = false
		off_sprite.visible = true

	else:
		if salected_power_up == 1:
			speed_sprite.visible = true
			off_sprite.visible = false
		if salected_power_up == 2:
			heal_sprite.visible = true
			off_sprite.visible = false
		if salected_power_up == 3:
			laser_sprite.visible = true
			off_sprite.visible = false

func _on_power_up_respawn_timer_timeout() -> void:
	if Global.selected_mode == 1:
		salected_power_up = randi_range(1, 3)
	elif Global.selected_mode == 2:
		salected_power_up = randi_range(1, 2)
	is_active = true
	_update_sprites()
