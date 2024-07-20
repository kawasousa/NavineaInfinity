extends Area2D

@onready var asteroids = $asteroids
@onready var collision_shape = $CollisionShape2D
var asteroidIndex: int
var speed: int = 0
var points_by_asteroid: int = 0
const EXPLOSION = preload("res://scenes/entities/explosion.tscn")

func _ready():
	choose_random_asteroid()

func _process(delta):
	translate(Vector2(speed, 0) * delta)
	rotate(-0.01)

## Verifica se a nave bateu no asteroid
func _on_body_entered(body):
	if body is Player:
		Global.player.subtractHitPoints(1)
		queue_free()

## Verifica se o tiro bateu no asteroid
func _on_area_entered(area):
	if area.is_in_group("PlayerProjectiles"):
		SoundManager.playSfx("explosion")
		
		area.queue_free()
		queue_free()
		
		var explosion = EXPLOSION.instantiate()
		get_parent().get_parent().get_node("explosion_group").add_child(explosion)
		explosion.global_position = global_position
		Global.explosion_node.show_explosion_animation(global_position)
		Global.add_points(points_by_asteroid)

## Exclui o asteroid se ele sai da tela
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

## Escolhe um asteroide aleatório dentre os possíveis asteroides
func choose_random_asteroid():
	for asteroid in asteroids.get_children():
		asteroid.visible = false
	asteroidIndex = (randi() % asteroids.get_child_count())
	var chosen_asteroid = asteroids.get_child(asteroidIndex)
	chosen_asteroid.visible = true
	# Define o raio da colisão como igual ao raio da textura do sprite escolhido
	collision_shape.shape.radius = chosen_asteroid.texture.get_width() / 2
	# Define a veloicidade do asteroide baseada em qual asteroid foi criado
	speed = Global.level.speed_factor * -100 * (asteroidIndex + 1)
	# Define a quantidade de pontos baseada em qual asteroid foi criado
	points_by_asteroid = asteroidIndex * 25
