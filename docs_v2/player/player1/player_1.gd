extends "res://player/personajes.gd"

var life = 100
var vidamax = 100
var contador: int = 0
var cantakedanmage = true

@onready var health_bar = $"../Player1/CanvasLayer/Barravida1"
@onready var kill_counter = $"../Player1/CanvasLayer/P1Muertes"
@onready var sprite = $Auto_P1
@onready var collision = $CollisionShape2D
@onready var respawntimer = $"../Player1/RespawnTimer1"
@onready var invi_timer = $"../Player1/InvincibilityTimer1"
@onready var speedtimer = $"../Player1/SpeedTimer1"
@onready var lasertime = $"../Player1/LaserTimer1"
@onready var explosion = $Explosion
@onready var explosion_sound = $Explosion1

func _ready():
	health_bar.vida_inicial(life)
	actualizar_contador()
	if Global.selected_mode == 2:
		kill_counter.visible = false
	sprite.play(str(Global.player1_selceted_car))
	if Global.player1_selceted_car == 1:
		collision.shape.height = 72
	elif Global.player1_selceted_car == 2:
		collision.shape.height = 68
	elif Global.player1_selceted_car == 3:
		collision.shape.height = 74
	elif Global.player1_selceted_car == 4:
		collision.shape.height = 70

func sumar_punto():
	Global.score1 += 1
	contador += 1
	actualizar_contador()

func actualizar_contador():
	kill_counter.text = str(contador)

func super_speed():
	engine_power = 95000.0
	braking = -65000.0
	speedtimer.start()

func laser_time():
	shoot_type = 2
	lasertime.start()

func take_damage(amount: int) -> void:
	if cantakedanmage == true:
		life -= amount
		health_bar.life = life
	if life >= vidamax:
		life = vidamax

	if life <= 0:
		sumar_punto()
		shoot_timer = 5.1
		desactivar_personaje()
		respawntimer.start()
		cantakedanmage = false

func desactivar_personaje():
	explosion_sound.play()
	explosion.play()
	sprite.visible = false
	collision.call_deferred("set_disabled", true)
	set_deferred("monitoring", false)

func _on_respawn_timer_1_timeout() -> void:
	position = Vector2(Global.p1_respawn_position, 540)
	global_rotation_degrees = 0
	invi_timer.start()
	cantakedanmage = false
	life = vidamax
	health_bar.life = life
	sprite.visible = true
	collision.call_deferred("set_disabled", false)
	set_deferred("monitoring", true)

func _on_invincibility_timer_1_timeout() -> void:
	cantakedanmage = true

func _on_speed_timer_1_timeout() -> void:
	braking = -45000.0
	engine_power = 60000.0

func _on_laser_timer_1_timeout() -> void:
	shoot_type = 1
