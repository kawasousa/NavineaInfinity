extends Area2D

@onready var sprite = $AnimatedSprite2D
const SPEED = 1000


func _process(delta):
	translate(Vector2(SPEED, 0) * delta)
	sprite.play("shoot")

## Apaga a instância do tiro quando ele sai da tela
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
