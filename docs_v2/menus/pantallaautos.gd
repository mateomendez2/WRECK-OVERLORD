extends Control


@onready var p1_car : int = 1
@onready var p2_car : int = 2
@onready var p1_picked = false
@onready var p2_picked = false
@onready var car_anim_p1 = $Auto_P1
@onready var car_anim_p2 = $Auto_P2
@onready var autorojo1 = $Autorojo1
@onready var autorojo2 = $Autorojo2
@onready var autoazul1 = $Autoazul1
@onready var autoazul2 = $Autoazul2
@onready var autolila1 = $Autolila1
@onready var autolila2 = $Autolila2
@onready var autonarnaja1 = $Autonaranja1
@onready var autonarnaja2 = $Autonaranja2
@onready var readybutton1 = $Botontilde1
@onready var readybutton2 = $Botontilde2
@onready var selection1 = $Selection1
@onready var selection2 = $Selection2
@onready var timer_ready = $Ready
@onready var timer_label = $TiempoLabel
@onready var car_pick_sound = $CarPick
@onready var wrong_sound = $Wrong

func _ready():
	if not Global.Music.playing:
		Global.Music.play()
	update_car()

func _physics_process(_delta):
	car_anim_p1.rotation_degrees += 1
	car_anim_p2.rotation_degrees -= 1
	get_input()
	timer_label.text = str(int(timer_ready.time_left))

func get_input():
	
	var p1_rigth = "steer_right1"
	var p1_left = "steer_left1"
	var p1_accept = "shoot1"
	var p1_back = "brake1"
	
	var p2_rigth = "steer_right2"
	var p2_left = "steer_left2"
	var p2_accept = "shoot2"
	var p2_back = "brake2"
	
	if Input.is_action_just_pressed(p1_left) and p1_car > 1 and p1_picked == false:
		p1_car -= 1
		update_car()
		
	if Input.is_action_just_pressed(p1_rigth) and p1_car < 4 and p1_picked == false:
		p1_car += 1
		update_car()
		
	if Input.is_action_just_pressed(p1_accept):
		if  p1_car == Global.player2_selceted_car:
			wrong_sound.play()
			return
		else:
			car_pick_sound.play()
			p1_picked = true
			Global.player1_selceted_car = p1_car
			readybutton1.play("ON")
			everyone_ready()
			if Global.player1_selceted_car == 1:
				autorojo1.modulate = Color("a0a0a0")
				autorojo2.modulate = Color("a0a0a0")
			elif Global.player1_selceted_car == 2:
				autoazul1.modulate = Color("a0a0a0")
				autoazul2.modulate = Color("a0a0a0")
			elif Global.player1_selceted_car == 3:
				autolila1.modulate = Color("a0a0a0")
				autolila2.modulate = Color("a0a0a0")
			elif Global.player1_selceted_car == 4:
				autonarnaja1.modulate = Color("a0a0a0")
				autonarnaja2.modulate = Color("a0a0a0")
	
	if Input.is_action_just_pressed(p1_back):
		if p1_picked == true:
			wrong_sound.play()
			p1_picked = false
			timer_ready.stop()
			timer_label.visible = false
			if Global.player1_selceted_car == 1:
				autorojo1.modulate = Color("ffffff")
				autorojo2.modulate = Color("ffffff")
			elif Global.player1_selceted_car == 2:
				autoazul1.modulate = Color("ffffff")
				autoazul2.modulate = Color("ffffff")
			elif Global.player1_selceted_car == 3:
				autolila1.modulate = Color("ffffff")
				autolila2.modulate = Color("ffffff")
			elif Global.player1_selceted_car == 4:
				autonarnaja1.modulate = Color("ffffff")
				autonarnaja2.modulate = Color("ffffff")
			Global.player1_selceted_car = 0
		readybutton1.play("OFF")

	if Input.is_action_just_pressed(p2_left) and p2_car < 4 and p2_picked == false:
		p2_car += 1
		update_car()
		
	if Input.is_action_just_pressed(p2_rigth) and p2_car > 1 and p2_picked == false:
		p2_car -= 1
		update_car()
		
	if Input.is_action_just_pressed(p2_accept):
		if p2_car == Global.player1_selceted_car:
			wrong_sound.play()
			return
		else:
			car_pick_sound.play()
			p2_picked = true
			Global.player2_selceted_car = p2_car
			readybutton2.play("ON")
			everyone_ready()
			if Global.player2_selceted_car == 1:
				autorojo1.modulate = Color("a0a0a0")
				autorojo2.modulate = Color("a0a0a0")
			elif Global.player2_selceted_car == 2:
				autoazul1.modulate = Color("a0a0a0")
				autoazul2.modulate = Color("a0a0a0")
			elif Global.player2_selceted_car == 3:
				autolila1.modulate = Color("a0a0a0")
				autolila2.modulate = Color("a0a0a0")
			elif Global.player2_selceted_car == 4:
				autonarnaja1.modulate = Color("a0a0a0")
				autonarnaja2.modulate = Color("a0a0a0")

	if Input.is_action_just_pressed(p2_back):
		if p2_picked == true:
			wrong_sound.play()
			p2_picked = false
			timer_ready.stop()
			timer_label.visible = false
			if Global.player2_selceted_car == 1:
				autorojo1.modulate = Color("ffffff")
				autorojo2.modulate = Color("ffffff")
			elif Global.player2_selceted_car == 2:
				autoazul1.modulate = Color("ffffff")
				autoazul2.modulate = Color("ffffff")
			elif Global.player2_selceted_car == 3:
				autolila1.modulate = Color("ffffff")
				autolila2.modulate = Color("ffffff")
			elif Global.player2_selceted_car == 4:
				autonarnaja1.modulate = Color("ffffff")
				autonarnaja2.modulate = Color("ffffff")
			Global.player2_selceted_car = 0
		readybutton2.play("OFF")

func update_car():
	car_anim_p1.play("Auto" + str(p1_car))
	car_anim_p2.play("Auto" + str(p2_car))
	if p1_car == 1:
		selection1.position.x = 130
	elif p1_car == 2:
		selection1.position.x = 300
	elif p1_car == 3:
		selection1.position.x = 470
	elif p1_car == 4:
		selection1.position.x = 640
	
	if p2_car == 1:
		selection2.position.x = 1790
	elif p2_car == 2:
		selection2.position.x = 1620
	elif p2_car == 3:
		selection2.position.x = 1450
	elif p2_car == 4:
		selection2.position.x = 1280

func everyone_ready():
	if p1_picked == true and p2_picked == true:
		timer_ready.start(3.9)
		timer_label.visible = true

func _on_ready_timeout() -> void:
	queue_free()
	Global.Music.stop()
	if Global.selected_mode == 1:
		get_tree().change_scene_to_file("res://player/modos/modo_1.tscn")
	if Global.selected_mode == 2:
		get_tree().change_scene_to_file("res://player/modos/modo_2.tscn")
