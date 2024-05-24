extends CanvasLayer

@onready var floating_animation = $game_over_rect/floating_animation
@onready var restart = $VBoxContainer/restart
@onready var high_score = $high_score
@onready var high_score_user: TextEdit = $new_high_score/high_score_user
var game_over_checker: bool = false
var new_hscore_setter: bool = false


func _ready():
	high_score_user.editable = false
	high_score_user.placeholder_text = Global.high_score_player

func _process(_delta):
	show_game_over_screen()
	update_high_score_label()
	set_new_high_score()

func _on_restart_pressed():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	visible = false
	Global.restart_game_values()

func show_game_over_screen() -> void:
	if Global.game_over:
		Engine.time_scale = 0.3
		visible = true
		if Global.new_high_score == false:
			grab_button_focus()
		floating_animation.play("floating")
		Global.player_node.animated_sprite_2d.play("idle")
		Global.player_node.rotate(0.001)
		Global.player_node.global_position.x -= 0.5

func _on_quit_to_menu_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func grab_button_focus() -> void:
	if game_over_checker == false:
		restart.grab_focus()
		game_over_checker = true

func update_high_score_label() -> void:
	high_score.text = "recorde: " + str(Global.high_score)

func set_new_high_score() -> void:
	if Global.new_high_score == true and new_hscore_setter == false:
		high_score_user.editable = true
		high_score_user.placeholder_text = "seu nome"
	else:
		high_score_user.editable = false
		print("Não foi um novo recorde. Editavel tá falso.")

func _on_set_new_high_score_player_pressed():
	Global.high_score_player = high_score_user.text
	Global.new_high_score = false
	new_hscore_setter = true
	print(Global.high_score_player)
	
