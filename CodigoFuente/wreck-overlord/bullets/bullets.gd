extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var speed: float = 3000
var owner_id: int = 0
var already_crashed: bool = false

@onready var bala = $Sprite2D
@onready var choque = $Choque

func _physics_process(delta):
	if already_crashed == true:
		return
	var collision = move_and_collide(direction * speed * delta)
	
	if collision:
		var other = collision.get_collider()
		
		# Verifica si tiene la propiedad player_id usando get() y comprobando null
		if other.is_in_group("Player") and other.get("player_id") != null:
			if other.player_id != owner_id:
				if other.cantakedanmage == true:
					other.take_damage(2)
				
		bala.visible = false
		already_crashed = true 
		choque.play()
		set_deferred("monitoring", false)
		

func _on_choque_animation_finished() -> void:
	queue_free()
