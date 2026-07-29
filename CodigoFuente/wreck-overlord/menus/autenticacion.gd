extends Control

@onready var botonplay = $Botonplay
@onready var cancontinue = false

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)

func _physics_process(_delta):
	get_input()

func get_input():
	var accept := "shoot1"
	if Input.is_action_just_pressed(accept):
		if cancontinue == true:
			queue_free()
			get_tree().change_scene_to_file("res://menus/seleccionidioma.tscn")

func _on_log_in_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.login_with_email_and_password(email, password)
	%LabelEstado.text = "Logging in"

func _on_sign_up_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	%LabelEstado.text = "Singing up"

func on_login_succeeded(auth):
	print(auth)
	%LabelEstado.text = "Loged in successfully"
	botonplay.visible = true
	cancontinue = true

func on_signup_succeeded(auth):
	print(auth)
	%LabelEstado.text = "Signed up successfully"
	botonplay.visible = true
	cancontinue = true

func on_login_failed(error_code, message):
	print(error_code, message)
	%LabelEstado.text = "Log in failed. Error : %s" % message

func on_signup_failed(error_code, message):
	print(error_code, message)
	%LabelEstado.text = "Sign up failed. Error : %s" % message

func _on_google_button_pressed() -> void:
	%LabelEstado.text = "Connecting to Google..."
	var provider: AuthProvider = Firebase.Auth.get_GoogleProvider()
	Firebase.Auth.get_auth_localhost(provider, 8060)

func _on_git_hub_button_pressed() -> void:
	%LabelEstado.text = "Connecting to Git Hub..."
	var provider: AuthProvider = Firebase.Auth.get_GitHubProvider()
	Firebase.Auth.get_auth_localhost(provider, 8060)

func _on_anonymous_button_pressed() -> void:
	Firebase.Auth.login_anonymous()

func _on_botonplay_pressed() -> void:
	if cancontinue == true:
		get_tree().change_scene_to_file("res://menus/seleccionidioma.tscn")
