extends Control
class_name Level

@onready var background_material: ShaderMaterial = $background.material
@onready var game_over_menu = $game_over_menu
@onready var ship = $ship
@onready var hit_points_label: Label = $hud/CenterContainer/HBoxContainer/hit_points
@onready var score_label: Label = %score
@onready var score_points: int = 0
var explosion = Global.explosion_node
var score_draw: int = 0
var displacement: int = 0
var pre_asteroid = preload("res://scenes/asteroid.tscn")
var max_ship_life: int = 4
var ship_life = max_ship_life
var speed_factor : int = 1

func _ready() -> void:
	Global.game_over = false
	Global.level_node = self

func _process(delta) -> void:
	move_backgroung()
	update_score()
	update_hit_points()
	if ship_life == 0:
		game_over_menu.show_game_over_screen()

## Subtrai a vida da nave
func subtract_ship_life() -> void:
	ship_life -= 1
	# tocar a animação de dano da ship

## Controla o nascimento dos asteróides em uma posição aleatória
func _on_asteroid_spawn_timer_timeout() -> void:
	var asteroid = pre_asteroid.instantiate()
	get_node("asteroids_group").add_child(asteroid)
	asteroid.global_position = Vector2(1030,  (randi() % 867))

## Timer que controla a velocidade dos asteroids criados
func _on_increase_ast_speed_timer_timeout() -> void:
	speed_factor += 1
	speed_factor = min(speed_factor, 10)

## Adiciona pontos ao nível
func add_points(points: int) -> void:
	score_points += points

## Atualiza os pontos mostrados na tela
# Define a velocidade em que os pontos aumentam
func update_score() -> void:
	var increase_speed = max((score_points - score_draw) / 20, 5)
	score_draw = move_toward(score_draw, score_points, increase_speed)
	score_label.text = "score:" + str(score_draw)

## Atualiza a vida do player
func update_hit_points() -> void:
	ship_life = max(ship_life, 0)
	hit_points_label.text = "vida: " + "<".repeat(ship_life)

## Move o fundo verticalmente de acordo com a posição do plyer
func move_backgroung() -> void:
	background_material.set_shader_parameter("displacement", (ship.global_position.y - 432) * 0.0005)

func show_explosion_animation(asteroid_global_position) -> void:
	Global.explosion_node.global_position = asteroid_global_position
	Global.explosion_node.play_animation()
