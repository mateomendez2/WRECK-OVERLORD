extends RigidBody2D

# Escena de la bala
var BulletScene = preload("res://bullets/bullets.tscn")
var LaserScene = preload("res://laser/laser.tscn")

# Parámetros del vehículo
@export var wheel_base := 70.0
@export var steering_angle := 70.0
@export var braking := -45000.0
@export var engine_power := 60000.0
@export var max_speed_reverse := 300.0
@export var shoot_cooldown := 0.05
@export var laser_cooldown := 1.00

# Física
@export var friction := 0.7
@export var drag := -0.4
@export var slip_speed := 300.0
@export var traction_fast := 0.04
@export var traction_slow := 0.08

# Estado
var steer_angle := 0.0
var shoot_timer := 0.0
var laser_timer := 0.0
var acceleration := Vector2.ZERO

@export var player_id: int = 1
@export var shoot_type: int = 1


func _physics_process(delta):
	shoot_timer -= delta
	laser_timer -= delta
	get_input()
	apply_friction()
	calculate_steering(delta)

	# Aplicar aceleración como fuerza
	if acceleration != Vector2.ZERO:
		apply_central_force(acceleration * delta * mass)


func get_input():
	var turn := 0
	var steer_right := "steer_right" + str(player_id)
	var steer_left  := "steer_left"  + str(player_id)
	var accelerate  := "accelerate"  + str(player_id)
	var brake       := "brake"       + str(player_id)
	var shoot       := "shoot"       + str(player_id)

	if Input.is_action_pressed(steer_right):
		turn += 1
	if Input.is_action_pressed(steer_left):
		turn -= 1
	steer_angle = turn * steering_angle

	acceleration = Vector2.ZERO

	if Input.is_action_pressed(accelerate):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed(brake):
		acceleration = transform.x * braking

	if Input.is_action_pressed(shoot):
		if Global.selected_mode == 1:
			if shoot_type == 1 and shoot_timer <= 0.0:
				shoot_bullet()
				shoot_timer = shoot_cooldown
			if shoot_type == 2 and laser_timer <= 0.0:
				shoot_laser()
				laser_timer = laser_cooldown


func shoot_bullet():
	var bullet = BulletScene.instantiate()
	bullet.owner_id = player_id
	bullet.global_position = global_position + transform.x * 60
	bullet.global_rotation = global_rotation
	bullet.direction = transform.x.normalized()
	get_parent().add_child(bullet)

func shoot_laser():
	var laser = LaserScene.instantiate()
	laser.owner_id = player_id
	var offset_distance = 1000  
	var forward = Vector2.RIGHT.rotated(rotation)
	laser.position = position + forward * offset_distance
	laser.rotation = rotation
	get_parent().add_child(laser)

func calculate_steering(delta):
	var rear_wheel = global_position - transform.x * wheel_base / 2.0
	var front_wheel = global_position + transform.x * wheel_base / 2.0

	var v = linear_velocity

	rear_wheel += v * delta
	front_wheel += v.rotated(deg_to_rad(steer_angle)) * delta

	var new_heading = (front_wheel - rear_wheel).normalized()

	var traction = traction_slow
	if v.length() > slip_speed:
		traction = traction_fast

	var d = new_heading.dot(v.normalized() if v.length() != 0 else Vector2.RIGHT)

	if d > 0:
		v = v.lerp(new_heading * v.length(), traction)
	elif d < 0:
		v = -new_heading * min(v.length(), max_speed_reverse)

	linear_velocity = v
	global_rotation = new_heading.angle()

func apply_friction():
	var v = linear_velocity

	if v.length() < 5:
		v = Vector2.ZERO

	var friction_force = v * friction
	var drag_force = v * v.length() * drag

	if v.length() < 100:
		friction_force *= 3

	acceleration += drag_force + friction_force
