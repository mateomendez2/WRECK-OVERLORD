extends Control

@onready var button_play = $Botonplay

func _ready():
	$Botonplay.grab_focus()
	$Botonplay.connect("pressed", Callable(self, "_on_play_pressed"))
	if not Global.Music.playing:
		Global.Music.play()

func _physics_process(_delta):
	get_input()

func get_input():
	var accept := "shoot1"
	if Input.is_action_just_pressed(accept):
		queue_free()
		get_tree().change_scene_to_file("res://menus/pantalla_controles.tscn")

func _on_play_pressed():
	queue_free()
	get_tree().change_scene_to_file("res://menus/pantalla_controles.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if button_play.has_focus():
			button_play.emit_signal("pressed")
