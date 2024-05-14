extends CanvasLayer

@onready var animation_player = $game_over_rect/floating_animation
@onready var restart = $CenterContainer/VBoxContainer/restart
@onready var ship = $"../ship"


func _on_restart_pressed():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	visible = false

func _on_quit_to_menu_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func show_game_over_screen() -> void:
	Engine.time_scale = 0.3
	restart.grab_focus()
	visible = true
	animation_player.play("floating")
	Global.game_over = true
