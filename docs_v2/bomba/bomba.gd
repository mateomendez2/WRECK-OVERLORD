extends Area2D

@onready var bomb = $Sprite2D
@onready var animation = $AnimatedSprite2D

func _on_timer_timeout() -> void:
	bomb.visible = false
	animation.play()
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage"):
			if body.cantakedanmage == true:
				body.take_damage(20)
			
	

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
