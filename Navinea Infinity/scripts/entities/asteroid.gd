extends Area2D

@onready var asteroids = $asteroids
@onready var collision_shape = $CollisionShape2D
var chosen_asteroid_index: int
var speed: int = 0
var points_by_asteroid: int = 0
const EXPLOSION = preload("res://scenes/explosion.tscn")

func _ready():
	choose_random_asteroid()

func _process(delta):
	translate(Vector2(speed, 0) * delta)
	rotate(-0.01)

## Verifica se a nave bateu no asteroid
func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.subtract_player_hp()
		queue_free()

## Verifica se o tiro bateu no asteroid
func _on_area_entered(area):
	if area.is_in_group("PlayerProjectiles"):
		area.queue_free()
		queue_free()
		var explosion = EXPLOSION.instantiate()
		get_parent().get_parent().get_node("explosion_group").add_child(explosion)
		explosion.global_position = global_position
		Global.explosion_node.show_explosion_animation(global_position)
		Global.add_points(points_by_asteroid)

## Apaga o asteroid se ele sai da tela
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

## Escolhe um asteroide aleatório dentre os possíveis asteroides
func choose_random_asteroid():
	for asteroid in asteroids.get_children():
		asteroid.visible = false
	chosen_asteroid_index = (randi() % asteroids.get_child_count()) + 1
	var chosen_asteroid = get_node("asteroids/asteroid-" + str(chosen_asteroid_index))
	chosen_asteroid.visible = true
	# Define o raio da colisão como igual ao raio da textura do sprite escolhido
	collision_shape.shape.radius = chosen_asteroid.texture.get_width() / 2
	# Define a veloicidade do asteroide baseada em qual asteroid foi criado
	speed = Global.level_node.speed_factor * -100 * chosen_asteroid_index
	# Define a quantidade de pontos baseada em qual asteroid foi criado
	points_by_asteroid += chosen_asteroid_index * 25
