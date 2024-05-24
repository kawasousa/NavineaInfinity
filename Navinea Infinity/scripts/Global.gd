extends Node

var level_node: Level
var player_node = null
var explosion_node = null
var game_over: bool = false
var high_score: int = 0
var high_score_player: String = ""
var new_high_score: bool = false
var player_score: int = 0
var max_player_hp: int = 4
var player_hp: int = max_player_hp

func _process(_delta):
	update_high_score()
	update_player_hp()
	set_new_high_score()

func add_points(points: int) -> void:
	player_score += points

func update_high_score() -> void:
	high_score = max(high_score, player_score)

func add_player_hp() -> void:
	player_hp += 1

func subtract_player_hp() -> void:
	player_hp -= 1
	player_node.play_damage_animation()

func update_player_hp() -> void:
	player_hp = max(player_hp, 0)
	if player_hp == 0:
		game_over = true

func restart_game_values() -> void:
	game_over = false
	player_hp = max_player_hp
	player_score = 0
	new_high_score = false

func set_new_high_score() -> void:
	if player_score >= high_score:
		new_high_score = true
