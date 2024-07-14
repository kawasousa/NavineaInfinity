extends Control

@onready var start_button: Button = $SubViewportContainer/SubViewport/start

func _ready() -> void:
	start_button.grab_focus()
	Global.restart_game_values()

##Muda a cena para o level
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/level.tscn")
