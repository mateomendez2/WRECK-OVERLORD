extends Area2D

var owner_id: int = 0  # ID del jugador que disparó

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(other: Node) -> void:
	if other.is_in_group("Player") and other.get("player_id") != null:
		if other.player_id != owner_id:
			if other.cantakedanmage == true:
				other.take_damage(20)

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
