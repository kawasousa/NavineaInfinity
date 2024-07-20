extends Node

var level: Level
var player: Player
var explosion_node = null

var game_over: bool = false

var player_score: int = 0
var high_score: int = 0
var high_score_player: String = "seu nome"
var new_high_score: bool = false
var new_hscore_checker: bool = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta):
	update_high_score()
	set_new_high_score()

func add_points(points: int) -> void:
	player_score += points

func update_high_score() -> void:
	high_score = max(high_score, player_score)

func restart_game_values() -> void:
	game_over = false
	player_score = 0
	new_high_score = false
	new_hscore_checker = false

func set_new_high_score() -> void:
	if player_score >= high_score and new_hscore_checker == false:
		new_high_score = true
		new_hscore_checker = true
