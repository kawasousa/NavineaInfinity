extends AnimatedSprite2D


func _ready():
	Global.explosion_node = self

# Elimina a animação quando ela terminar
func _on_animation_finished():
	queue_free()

## Dá play na animação
func play_animation():
	show()
	play("explosion")

func show_explosion_animation(asteroid_global_position) -> void:
	Global.explosion_node.global_position = asteroid_global_position
	Global.explosion_node.play_animation()
