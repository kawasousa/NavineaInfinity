extends Control
class_name Level

@onready var background_material: ShaderMaterial = $SubViewportContainer/SubViewport/background.material
@onready var asteroid_groups = $SubViewportContainer/SubViewport/asteroids_group
var displacement: int = 0
var pre_asteroid = preload("res://scenes/entities/asteroid.tscn")
var speed_factor : int = 1
var can_spawn_enemies: bool = false

func _ready() -> void:
	Global.level = self
	Global.restart_game_values()

func _process(_delta) -> void:
	move_backgroung()

## Controla o nascimento dos asteróides em uma posição aleatória
func _on_asteroid_spawn_timer_timeout() -> void:
	if can_spawn_enemies:
		var asteroid = pre_asteroid.instantiate()
		asteroid.global_position = Vector2(1030,  (randi() % 867))
		asteroid_groups.add_child(asteroid)

## Timer que controla a velocidade dos asteroids criados
func _on_increase_ast_speed_timer_timeout() -> void:
	if can_spawn_enemies:
		speed_factor += 1
		speed_factor = min(speed_factor, 15)

## Move o fundo verticalmente de acordo com a posição do plyer
func move_backgroung() -> void:
	background_material.set_shader_parameter("displacement", (Global.player.global_position.y - 432) * 0.0005)
